---
name: performance-engineering
description: Investigates performance bottlenecks and proposes measured optimizations without premature complexity.
---

# Performance engineering

1. Define the user-visible performance problem and target workload.
2. Establish a baseline using profiling, traces, query plans, or reproducible measurements.
3. Identify the bottleneck before changing code.
4. Consider algorithmic complexity, network round trips, N+1 queries, caching, payload size, rendering, concurrency, and resource limits.
5. Optimize the narrowest bottleneck and preserve correctness/security.
6. Measure before and after under comparable conditions.
7. Document trade-offs, cache invalidation, capacity assumptions, and regression monitoring.

Do not claim performance improvement without measurements. Avoid speculative caching or premature micro-optimization.
