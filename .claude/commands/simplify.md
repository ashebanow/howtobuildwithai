| #  | Strategy                                      | Core idea                                                            | Example in practice                                       |
| -- | --------------------------------------------- | -------------------------------------------------------------------- | --------------------------------------------------------- |
| 1  | **Divide & Conquer**                          | Split into independent chunks, solve recursively, merge.             | Merge‑sort; chunked image processing.                     |
| 2  | **Pre‑indexing / Preprocessing**              | Heavy upfront work to build an index so queries are O(1)–O(log n).   | Inverted index + Bloom filters for full‑text search.      |
| 3  | **Early‑Rejection Filters**                   | Cheap coarse test prunes 90‑99 % of candidates.                      | Axis‑aligned bounding‑box check before polygon overlap.   |
| 4  | **Memoization & Dynamic Programming**         | Cache solutions to overlapping sub‑problems, avoid recomputation.    | Levenshtein distance DP table instead of naïve recursion. |
| 5  | **Greedy / Heuristic Search**                 | Use a domain‑specific heuristic to guide to “good enough” quickly.   | A\* with Manhattan distance for grid pathfinding.         |
| 6  | **Approximation / Relaxation**                | Solve an easier variant that’s close enough; refine on demand.       | Christofides’ 1.5‑approximation for TSP.                  |
| 7  | **Sampling & Sketching**                      | Operate on a representative subset or compressed summary.            | HyperLogLog to count unique visitors in streaming logs.   |
| 8  | **Problem Transformation**                    | Map into a domain with cheaper ops.                                  | FFT turns convolution from O(n²) to O(n log n).           |
| 9  | **Parallel Partitioning**                     | Slice the workload across cores/nodes, merge partial results.        | MapReduce word‑count on log shards.                       |
| 10 | **Constraint Propagation / Branch‑and‑Bound** | Tighten bounds so large parts of the search tree are never explored. | Integer LP solver pruning impossible regions.             |

Task: Propose at least 5 distinct complexity‑reduction strategies.
For each strategy:
• **Name** it (e.g. “Divide & Conquer”).
• Explain in ≤2 sentences how it simplifies the problem.
• Provide a concrete example tailored to this problem.
• State the main trade‑off (time, memory, accuracy, etc.).

Return as a numbered list. No fluff.
