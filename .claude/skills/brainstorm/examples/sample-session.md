# Example: Rate Limiting for a Public API

**Problem:** "How should we handle rate limiting for our public API?"

## Wave 1: The Obvious (1-10)

1. Token bucket per API key
2. Fixed window counter
3. Sliding window log
4. Redis-backed rate limiter
5. API Gateway built-in (Kong / AWS API Gateway)
6. Leaky bucket algorithm
7. Per-endpoint rate limits
8. Tiered limits by plan (free/pro/enterprise)
9. IP-based fallback for unauthenticated requests
10. 429 response with Retry-After header

## Wave 2: The Stretch (11-20)

11. Client-side rate awareness SDK (clients self-throttle)
12. Graceful degradation — return partial/cached responses instead of 429
13. Cost-based limits — heavy queries cost more quota
14. Collaborative limits — org-wide shared pool
15. Predictive throttling — ML on usage patterns to pre-warn
16. Request queuing instead of rejection (async processing)
17. Circuit breaker per-client (escalating backoff)
18. Geographic distribution of limit pools
19. Webhook callback instead of polling (reduce request volume)
20. Read/write split limits (reads are cheap, writes are expensive)

## Wave 3: The Deep End (21-30)

21. Auction system — clients bid for capacity with credits
22. Peer-to-peer rate negotiation between API consumers
23. Remove rate limits entirely, charge per-request (pure usage billing)
24. "Slow mode" — serve stale cache at degraded latency instead of rejecting
25. Client-reported importance scores on requests
26. Time-of-day dynamic limits (more capacity off-peak)
27. Batch API that's unlimited but async with SLA
28. Let clients declare expected usage upfront (capacity reservation)
29. Rate limit the rate limiter (meta-limits for fairness across limit pools)
30. Public real-time capacity dashboard + webhooks for capacity changes

## Convergence

| # | Title | F | N | I | Total |
|---|-------|---|---|---|-------|
| 12 | Graceful degradation | 4 | 3 | 5 | 12 |
| 13 | Cost-based limits | 3 | 4 | 5 | 12 |
| 24 | Slow mode (stale cache) | 4 | 4 | 4 | 12 |
| 27 | Batch API unlimited/async | 3 | 3 | 5 | 11 |
| 20 | Read/write split limits | 5 | 2 | 4 | 11 |
| 11 | Client-side SDK | 5 | 2 | 4 | 11 |

**Selected for exploration:** #12 (graceful degradation), #13 (cost-based), #24 (slow mode)

**Why these three?** They share a theme: instead of binary accept/reject, they introduce
a spectrum of service quality. This reframes rate limiting from a wall into a gradient —
which is the non-obvious insight that emerged from pushing past the first 10 ideas.
