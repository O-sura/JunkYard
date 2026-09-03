# Analytics Event → OpenTelemetry Attribute Mapping

Maps every field of the canonical analytics event (`dto.Event` and everything reachable from it)
onto an OpenTelemetry attribute, preferring an existing convention over an invented one and marking
clearly where no convention exists.

---

## 0. Sources of truth, and one thing that changed

| Convention family | Where it lives | Stability |
|---|---|---|
| `http.*`, `url.*`, `client.*`, `server.*`, `user_agent.*`, `error.type`, `network.*` | `open-telemetry/semantic-conventions` | **Stable** since semconv v1.23.1 |
| `service.*` (resource) | same | **Stable** |
| `user.*`, `session.*`, `deployment.environment.name` | same | Development |
| `rpc.*`, `jsonrpc.*` | same | Development / RC |
| **`gen_ai.*`, `mcp.*`** | **`open-telemetry/semantic-conventions-genai`** | **Development — nothing Stable** |

**The GenAI and MCP conventions moved out of the main repo** at semconv v1.42.0 (June 2026). The
entries still visible at `opentelemetry.io/docs/specs/semconv/registry/attributes/gen-ai/` and
`.../mcp/` are **deprecated stubs** pointing at the new repo — don't map against them. Everything in
the GenAI repo carries `development` stability, so names can change without a major version bump.

### Stability legend used in the tables

| Tag | Meaning |
|---|---|
| `STABLE` | Frozen by OpenTelemetry. Safe to depend on. |
| `DEV` | Standard exists, but Development-stability. Use it, confine the name to the exporter. |
| `RC` | Release candidate. |
| `CUSTOM` | No convention exists. We define it. |

---

## 1. Rules for the custom namespace

1. **Prefix `wso2.`** for everything we define — decided, matching Kong's `kong.*` precedent.
   Never mix in a second prefix.
2. **A standard at Development stability still beats a custom attribute.** Churn in one exporter file
   is cheaper than a name nobody else understands.
3. **Never reuse a standard name with a different meaning.** If our semantics differ even slightly,
   use `wso2.*` — a subtly-wrong `http.route` is worse than an honest `wso2.api.resource_template`.
4. **Don't emit what is derivable**, unless a consumer genuinely can't compute it (noted per row).
5. **All `gen_ai.*` and `mcp.*` naming lives in one exporter function**, so a convention rename is a
   single-file change.

---

## 2. Resource attributes — set once per emitter, not per record

| Value | Attribute | Stability | Notes |
|---|---|---|---|
| `"policy-engine"` | `service.name` | STABLE | Already emitted by the POC |
| gateway version | `service.version` | STABLE | Not yet wired |
| `"api-platform"` | `service.namespace` | STABLE | Already emitted |
| `MetaInfo.GatewayType` | `wso2.gateway.type` | CUSTOM | No standard for "which gateway flavour" |
| `MetaInfo.RegionID` | `cloud.region` | DEV | Use the standard if it really is a cloud region; otherwise `wso2.region.id` |
| deployment env | `deployment.environment.name` | DEV | Note the `.name` suffix — renamed from `deployment.environment` |
| `ExtendedAPI.OrganizationID` | `wso2.organization.id` | CUSTOM | **Resource, not record** — constant per gateway deployment |
| `ExtendedAPI.EnvironmentID` | `wso2.environment.id` | CUSTOM | Same |

> Resource attributes cost nothing per record, so anything constant for the lifetime of the emitter
> belongs here rather than on every log record.

---

## 3. Log record envelope

| Event field | OTLP field | Stability | Notes |
|---|---|---|---|
| `RequestTimestamp` | `timeUnixNano` | STABLE | Nanoseconds as a JSON **string** (proto3 mapping) |
| — (export time) | `observedTimeUnixNano` | STABLE | |
| constant | `eventName` = `wso2.api.transaction` | DEV | Also emit as an `event.name` **attribute**: collectors before ~v0.117 drop the top-level field. Verified: 0.112.0 drops it. |
| constant | `severityNumber` = 9 / `severityText` = `INFO` | STABLE | A transaction is not a diagnostic, but unset severity is bucketed inconsistently by backends |
| — | `traceId` / `spanId` | STABLE | Correlation to the request trace when tracing is on. **Not yet wired** |
| method + path | `body` | STABLE | Human-readable summary only; all data lives in attributes |

**One `event.name` for every API type.** `wso2.api.type` is the discriminator — separate event names
per type (`...rest.transaction`, `...llm.transaction`) would force consumers to enumerate names to
get a total request count.

---

## 4. Field-by-field mapping

### 4.1 HTTP and transport

| Event field | OTel attribute | Stability | Notes |
|---|---|---|---|
| `Operation.APIMethod` | `http.request.method` | STABLE | Uppercase per convention |
| `Operation.APIResourceTemplate` | `http.route` | STABLE | Already the full path incl. context — **do not concatenate with `APIContext`** |
| `Operation.APIResourceTemplate` | `url.path` | STABLE | Same value today; diverges if a concrete path is ever captured |
| `ProxyResponseCode` | `http.response.status_code` | STABLE | Status the client saw |
| `UserIP` | `client.address` | STABLE | |
| `UserAgentHeader` | `user_agent.original` | STABLE | Moesif only gets UA if the header-filter policy is enabled |
| `Target.Destination` | `wso2.upstream.destination` | CUSTOM | **Corrected.** Built as `authority + path`, so the whole value is not a hostname |
| `Target.Destination` (authority half) | `server.address` / `server.port` | STABLE | Split at the first `/`, then `net.SplitHostPort` |
| `Target.TargetResponseCode` | `wso2.upstream.response.status_code` | CUSTOM | No standard for "upstream status distinct from client status" |
| `Target.ResponseCodeDetail` | `wso2.upstream.response.detail` | CUSTOM | Envoy's `response_code_details` |
| `Target.ResponseCacheHit` | `wso2.cache.hit` | CUSTOM | |
| `Properties["requestSize"]` | `http.request.body.size` | DEV | |
| `Properties["responseSize"]` | `http.response.body.size` | DEV | |
| `Properties["responseContentType"]` | `wso2.response.content_type` | CUSTOM | No standard content-type attribute |
| `Properties[requestHeaders]` | `http.request.header.<key>` | STABLE | Convention is one attribute per header, lowercased, array-valued. Opt-in only |
| `Properties[responseHeaders]` | `http.response.header.<key>` | STABLE | Same |

### 4.2 API identity

| Event field | OTel attribute | Stability | Notes |
|---|---|---|---|
| `API.APIID` | `wso2.api.id` | CUSTOM | |
| `API.APIName` | `wso2.api.name` | CUSTOM | |
| `API.APIVersion` | `wso2.api.version` | CUSTOM | |
| `ExtendedAPI.APIContext` | `wso2.api.context` | CUSTOM | |
| `API.APIType` | `wso2.api.type` | CUSTOM | `RestApi` \| `LlmProvider` \| `LlmProxy` \| `Mcp` |
| `API.SubType` | `wso2.api.subtype` | CUSTOM | Mirrors `APIType` today; kept so it can diverge |
| `ExtendedAPI.ProjectID` | `wso2.project.id` | CUSTOM | |
| `API.APICreator` | `wso2.api.creator` | CUSTOM | |
| `API.APICreatorTenantDomain` | `wso2.api.creator.tenant_domain` | CUSTOM | |

### 4.3 Consumer identity — the axis metrics can't hold

| Event field | OTel attribute | Stability | Notes |
|---|---|---|---|
| `Properties["x-wso2-user-id"]` | `user.id` | DEV | **Prefer `user.id`** — `enduser.id` is deprecated as of semconv v1.27.0 |
| `UserName` | `user.name` | DEV | Moesif uses only the user-id property |
| `Application.ApplicationID` | `wso2.application.id` | CUSTOM | |
| `Application.ApplicationName` | `wso2.application.name` | CUSTOM | |
| `Application.ApplicationOwner` | `wso2.application.owner` | CUSTOM | |
| `Application.KeyType` | `wso2.application.key_type` | CUSTOM | PRODUCTION / SANDBOX — surprising omission from Moesif |
| `Subscription.BillingSubscriptionID` | `wso2.subscription.id` | CUSTOM | |
| `Subscription.BillingCustomerID` | `wso2.subscription.customer.id` | CUSTOM | |
| `Subscription.Status` | `wso2.subscription.status` | CUSTOM | |
| `Subscription.PlanName` | `wso2.subscription.plan` | CUSTOM | |
| `MetaInfo.CorrelationID` | `wso2.correlation.id` | CUSTOM | Also the natural **idempotency key** for de-duplicating retries |

### 4.4 Latency — no standard attribute exists for any of these

OpenTelemetry expresses duration as the span duration or as the
`http.server.request.duration` **metric**, not as a log attribute. All four are therefore custom.
Units: the event carries **milliseconds**.

| Event field | OTel attribute | Stability | Notes |
|---|---|---|---|
| `Latencies.ResponseLatency` | `wso2.latency.response_ms` | CUSTOM | |
| `Latencies.BackendLatency` | `wso2.latency.backend_ms` | CUSTOM | |
| `Latencies.RequestMediationLatency` | `wso2.latency.request_mediation_ms` | CUSTOM | |
| `Latencies.ResponseMediationLatency` | `wso2.latency.response_mediation_ms` | CUSTOM | |
| `Latencies.Duration` | `wso2.latency.duration_ms` | CUSTOM | |
| `TrafficLogLatencies.*` (µs) | — | — | `json:"-"`; traffic-log publisher only. Don't map |

> Consider suffix-free names with a `unit` in documentation instead of `_ms`, if you'd rather not bake
> the unit into the attribute name. Baking it in is the safer choice for a mixed-precision codebase.

### 4.5 Faults and errors

| Event field | OTel attribute | Stability | Notes |
|---|---|---|---|
| `ErrorType` | `error.type` | **STABLE** | The one stable error attribute. Values should be low-cardinality |
| `Error.ErrorCode` | `wso2.error.code` | CUSTOM | WSO2 numeric fault code |
| `Error.ErrorMessage` (`FaultSubCategory`) | `wso2.error.sub_category` | CUSTOM | Enum: `AUTHENTICATION_FAILURE`, `API_LEVEL_LIMIT_EXCEEDED`, … |
| `FaultCategory` (derived) | `wso2.error.category` | CUSTOM | `AUTH` \| `TARGET_CONNECTIVITY` \| `THROTTLED` \| `OTHER` |
| `EventCategory` (derived) | `wso2.event.category` | CUSTOM | `SUCCESS` \| `FAULT` \| `INVALID` |

**The whole fault taxonomy is invisible to Moesif today.** For a customer asking "why are calls
failing", this is the most valuable block on the event, and none of it currently leaves the gateway.

### 4.6 Payloads

| Event field | OTel attribute | Stability | Notes |
|---|---|---|---|
| `Properties["request_payload"]` | `wso2.request.body` | CUSTOM | Only when `[collector] request_body` is on |
| `Properties["response_payload"]` | `wso2.response.body` | CUSTOM | Only when `[collector] response_body` is on |

Bodies belong in the record `body` or a dedicated attribute, never on a span. SDK attribute limits
default to 128 attributes and backends commonly truncate long values — size-cap before emitting.

### 4.7 GenAI — `LlmProvider` and `LlmProxy`

Authoritative source: `semantic-conventions-genai`. All `gen_ai.*` are **DEV**.

| Event field | OTel attribute | Stability | Notes |
|---|---|---|---|
| `AIMetadata.VendorName` | `gen_ai.provider.name` | DEV | **Enum — needs normalization, see §5** |
| `AIMetadata.Model` | `gen_ai.response.model` | DEV | **Corrected.** `aitoken:modelid` is `ResponseModel` when the provider returns one, falling back to `RequestModel` — so this value is normally the *responding* model, not the requested one |
| `LLMProviderAnalyticsInfo.RequestModel` | `gen_ai.request.model` | DEV | **Available upstream but discarded.** The analytics system policy collapses `RequestModel` and `ResponseModel` into one metadata key |
| `AITokenUsage.PromptToken` | `gen_ai.usage.input_tokens` | DEV | |
| `AITokenUsage.CompletionToken` | `gen_ai.usage.output_tokens` | DEV | |
| `AITokenUsage.TotalToken` | `wso2.gen_ai.usage.total_tokens` | CUSTOM | **No standard total exists.** Derivable, but **decided: emit it** — dashboards and quotas read it directly |
| `AITokenUsage.Hour` | — | — | Aggregation artefact. **Don't map** |
| `AIMetadata.LLMCost` / `Properties["llmCost"]` | `wso2.gen_ai.cost.total` | CUSTOM | **No cost attribute exists in the GenAI conventions** — verified against the registry YAML. Kong hit the same wall and invented `kong.gen_ai.llm.cost` |
| `AIMetadata.VendorVersion` | `wso2.gen_ai.provider.api_version` | CUSTOM | |
| — | `gen_ai.operation.name` | DEV | Enum: `chat`, `embeddings`, `text_completion`, … Derivable from the route. **Gap worth closing** |
| `Properties["isEgress"]` | `wso2.gen_ai.egress` | CUSTOM | |
| `Properties["subtype"]` = `AIAPI` | — | — | Redundant with `wso2.api.type`. **Drop** |
| `Properties["isGuardrailHit"]` | `wso2.guardrail.hit` | CUSTOM | |
| `Properties["guardrailName"]` | `wso2.guardrail.name` | CUSTOM | |

**Cost must always carry the pricing-config version that produced it** (`wso2.gen_ai.cost.pricing_version`)
— costs get recomputed, and a number without its basis can't be audited.

#### The token taxonomy is already computed — and then thrown away

This is not missing instrumentation. `sdk/ai/llmusage.Usage` **already resolves** the full breakdown
per request. The loss happens at the policy boundary: `LLMProviderAnalyticsInfo` carries only
`PromptTokens`, `CompletionTokens`, `TotalTokens`, `RemainingTokens`, `RequestModel`, `ResponseModel`
— so everything else is discarded before it reaches the event.

| Already in `llmusage.Usage` | Standard attribute | Stability | Why it matters |
|---|---|---|---|
| `CachedReadTokens` | `gen_ai.usage.cache_read.input_tokens` | DEV | Cached prompt tokens bill at a different rate — often the single biggest cost lever |
| `CacheWriteTokens`, `CacheWrite1hTokens` | `gen_ai.usage.cache_write.input_tokens` | DEV | Cache-creation rates; the 1h variant is a separate rate |
| `ReasoningTokens` | `gen_ai.usage.reasoning.output_tokens` | DEV | Reasoning models bill these separately; Azure already differentiates them |
| `AudioInputTokens` | `gen_ai.usage.audio.input_tokens` | DEV | |
| `AudioOutputTokens` | `gen_ai.usage.audio.output_tokens` | DEV | |
| `UncachedInputTokens` | `gen_ai.usage.text.input_tokens` | DEV | The subset billed at the standard input rate |
| `ServiceTier` / `IsPriority` | `wso2.gen_ai.service_tier` | CUSTOM | `priority` \| `flex` \| `batch` — a **billing-rate** dimension with no OTel equivalent |
| `ModelCandidates` | `wso2.gen_ai.model_candidates` | CUSTOM | The fallback chain that was tried |
| `RemainingTokens` | `wso2.gen_ai.quota.remaining_tokens` | CUSTOM | From provider rate-limit headers; never reaches the event today |

**Widening `LLMProviderAnalyticsInfo` is the highest-value change in this document.** A customer
asking "why is my bill what it is" cannot be answered with prompt/completion/total alone once caching,
reasoning and service tiers are in play — and the gateway already knows all of it.

Not yet captured anywhere, worth adding at the same time:

| Standard attribute | Stability | Why it matters |
|---|---|---|
| `gen_ai.response.finish_reasons` | DEV | Truncation vs completion — explains cost anomalies |
| `gen_ai.request.stream` | DEV | |
| `gen_ai.response.time_to_first_chunk` | DEV | Streaming UX metric |
| `gen_ai.conversation.id` | DEV | Groups a multi-turn session |

### 4.8 MCP — `Mcp` API type

Authoritative source: `semantic-conventions-genai/docs/gen-ai/mcp.md`. Our data comes from
`Properties["mcpAnalytics"]`, assembled by the analytics system policy.

| Source field | OTel attribute | Stability | Notes |
|---|---|---|---|
| `mcpAnalytics.jsonRpcMethod` | `mcp.method.name` | DEV | **Required** in the convention. Enum of 27 values (`tools/call`, `resources/read`, `initialize`, …) |
| `mcpAnalytics.sessionId` | `mcp.session.id` | DEV | |
| `mcpAnalytics.capabilityName` **when** `capability=TOOL` | `gen_ai.tool.name` | DEV | |
| `mcpAnalytics.capabilityName` **when** `capability=RESOURCE` | `mcp.resource.uri` | DEV | Mapped, but **empty in practice**: `capabilityName` comes from `$.params.name`, while `resources/read` carries the URI at `$.params.uri`. `McpResourceUriJsonPath` is declared in the analytics policy and never used |
| `mcpAnalytics.capabilityName` **when** `capability=PROMPT` | `gen_ai.prompt.name` | DEV | |
| `mcpAnalytics.capability` | — | — | **Drop.** In OTel the capability is expressed by *which* attribute above is populated, and it's derivable from `mcp.method.name`'s prefix |
| `mcpAnalytics.errorCode` | `rpc.response.status_code` | RC | JSON-RPC error code, as a string |
| `mcpAnalytics.isError` | `error.type` | STABLE | Presence signals the error; don't emit a boolean |
| `serverInfo.protocolVersion` | `mcp.protocol.version` | DEV | The **negotiated** version |
| `clientInfo.requestedProtocolVersion` | `wso2.mcp.client.requested_protocol_version` | CUSTOM | OTel has one protocol-version attribute; requested-vs-negotiated needs ours |
| `clientInfo.name` | `wso2.mcp.client.name` | CUSTOM | No standard MCP client-identity attribute |
| `clientInfo.version` | `wso2.mcp.client.version` | CUSTOM | |
| `serverInfo.name` | `wso2.mcp.server.name` | CUSTOM | |
| `serverInfo.version` | `wso2.mcp.server.version` | CUSTOM | |
| — | `jsonrpc.request.id` | DEV | **Not captured — gap.** The per-request JSON-RPC id |
| — | `network.transport` | STABLE | `tcp` for HTTP-based MCP, `pipe` for stdio. Cheap to add |

**A flattening decision is needed.** `mcpAnalytics` is a nested map today. OTLP attributes are flat
key/values, so either flatten to the attribute names above (recommended — queryable in every backend)
or emit the map as one JSON-encoded string (loses queryability). Flatten.

---

## 5. `gen_ai.provider.name` is an enum — normalize our values

Our provider names come from the `ai:providername` metadata key, sourced from the LLM provider
template `name`. They do **not** match the convention's well-known values. Without this table the
attribute is technically populated but useless for cross-vendor comparison.

| WSO2 template name | `gen_ai.provider.name` | Exact match? |
|---|---|---|
| `openai` | `openai` | ✓ |
| `anthropic` | `anthropic` | ✓ |
| `awsbedrock` | `aws.bedrock` | ✗ rename |
| `azure-openai` | `azure.ai.openai` | ✗ rename |
| `azureai-foundry` | `azure.ai.inference` | ✗ rename |
| `gemini` | `gcp.gemini` | ✗ rename |
| `mistralai` | `mistral_ai` | ✗ rename |

Full enum: `openai`, `gcp.gen_ai`, `gcp.vertex_ai`, `gcp.gemini`, `anthropic`, `cohere`,
`azure.ai.inference`, `azure.ai.openai`, `ibm.watsonx.ai`, `aws.bedrock`, `perplexity`, `x_ai`,
`deepseek`, `groq`, `mistral_ai`, `moonshot_ai`.

**Keep the raw value too**, as `wso2.gen_ai.provider.template_name` — an unmapped custom provider
would otherwise lose its identity when it falls through the table. Unknown names should pass through
to that attribute and leave `gen_ai.provider.name` unset rather than guessing.

---

## 6. Custom attribute inventory

Everything we invent, in one place. Twelve of these exist because OpenTelemetry genuinely defines
nothing equivalent — API-product concepts and cost, chiefly.

**API product & identity:** `wso2.api.id` · `wso2.api.name` · `wso2.api.version` ·
`wso2.api.context` · `wso2.api.type` · `wso2.api.subtype` · `wso2.api.creator` ·
`wso2.api.creator.tenant_domain` · `wso2.project.id` · `wso2.organization.id`¹ ·
`wso2.environment.id`¹ · `wso2.gateway.type`¹

**Consumer:** `wso2.application.id` · `wso2.application.name` · `wso2.application.owner` ·
`wso2.application.key_type` · `wso2.subscription.id` · `wso2.subscription.customer.id` ·
`wso2.subscription.status` · `wso2.subscription.plan` · `wso2.correlation.id`

**Latency:** `wso2.latency.response_ms` · `wso2.latency.backend_ms` ·
`wso2.latency.request_mediation_ms` · `wso2.latency.response_mediation_ms` ·
`wso2.latency.duration_ms`

**Upstream & cache:** `wso2.upstream.response.status_code` · `wso2.upstream.response.detail` ·
`wso2.cache.hit` · `wso2.response.content_type`

**Faults:** `wso2.error.code` · `wso2.error.sub_category` · `wso2.error.category` ·
`wso2.event.category`

**Payloads:** `wso2.request.body` · `wso2.response.body`

**GenAI:** `wso2.gen_ai.usage.total_tokens` · `wso2.gen_ai.cost.total` ·
`wso2.gen_ai.cost.pricing_version` · `wso2.gen_ai.provider.api_version` ·
`wso2.gen_ai.provider.template_name` · `wso2.gen_ai.egress` · `wso2.guardrail.hit` ·
`wso2.guardrail.name`

**MCP:** `wso2.mcp.client.name` · `wso2.mcp.client.version` ·
`wso2.mcp.client.requested_protocol_version` · `wso2.mcp.server.name` · `wso2.mcp.server.version`

¹ resource-level, not per-record.


---

## Sources

OpenTelemetry — [HTTP conventions declared stable](https://opentelemetry.io/blog/2023/http-conventions-declared-stable/) ·
[HTTP semconv migration](https://opentelemetry.io/docs/specs/semconv/non-normative/http-migration/) ·
[deprecated gen_ai registry stub](https://opentelemetry.io/docs/specs/semconv/registry/attributes/gen-ai/) ·
[deprecated mcp registry stub](https://opentelemetry.io/docs/specs/semconv/registry/attributes/mcp/) ·
[enduser attributes (deprecated)](https://opentelemetry.io/docs/specs/semconv/registry/attributes/enduser/) ·
[deployment environment](https://opentelemetry.io/docs/specs/semconv/resource/deployment-environment/)

GenAI conventions repo — [semantic-conventions-genai](https://github.com/open-telemetry/semantic-conventions-genai) ·
[MCP conventions](https://github.com/open-telemetry/semantic-conventions-genai/blob/main/docs/gen-ai/mcp.md) ·
gen_ai + mcp registry YAML (`model/gen-ai/registry.yaml`, `model/mcp/registry.yaml`)

Stability status — [state of the GenAI semconv, July 2026](https://john-hodge.com/blog/opentelemetry-genai-semantic-conventions/) ·
[what shipped in 2026](https://dev.to/azena-ai/opentelemetrys-genai-semantic-conventions-are-not-stable-yet-heres-what-actually-shipped-in-2026-3mke)

Precedent for a custom cost attribute — [Kong AI OTLP metrics reference](https://developer.konghq.com/ai-gateway/ai-otel-metrics/)

In-repo — `internal/analytics/dto/*.go` · `internal/analytics/analytics.go` ·
`internal/analytics/publishers/moesif.go` · `internal/analytics/publishers/otel.go` ·
`internal/constants/constants.go` · `system-policies/analytics/analytics.go` ·
`gateway-controller/default-llm-provider-templates/`
