## Week 3 — Wednesday Graph QA Log

### Insights & Observations

- Successfully loaded the synthetic portfolio from PostgreSQL into a NetworkX DiGraph framework and rendered the topology via Matplotlib.
- The graph shows a clear central density hub around the core backend monoliths and COTS platforms, representing realistic enterprise "blast radius" profiles.
- Microservices successfully clustered together with higher out-degree values, while internal tools settled safely out on the periphery of the network map.

### Engineering Question for Later

- When analyzing large-scale enterprise graphs with thousands of applications instead of 50, how do architects handle visual clutter or partition the graph into distinct business domains without breaking the cross-domain dependency visibility?
