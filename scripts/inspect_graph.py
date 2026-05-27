# scripts/inspect_graph.py
"""Loads the dependency graph from the DB into NetworkX and prints stats.

Run after generate.py to sanity-check the synthetic portfolio.
"""
import os
import sys
import networkx as nx
import matplotlib.pyplot as plt

# Dynamic path configuration to ensure root package lookups work perfectly
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if project_root not in sys.path:
    sys.path.append(project_root)

from db.session import SessionLocal
from db.models import Application, Dependency

def build_graph() -> nx.DiGraph:
    """Extracts data from Postgres and constructs a NetworkX Directed Graph."""
    with SessionLocal() as session:
        apps = session.query(Application).all()
        deps = session.query(Dependency).all()
        
        g = nx.DiGraph()
        
        # Add applications as nodes with tracking attributes
        for app in apps:
            g.add_node(app.id, name=app.name, archetype=app.archetype.value)
            
        # Add dependencies as directed edges (source application -> target application)
        for dep in deps:
            g.add_edge(dep.source_app_id, dep.target_app_id, protocol=dep.protocol)
            
        return g

def print_stats(g: nx.DiGraph) -> None:
    """Analyzes the structural properties of the generated corporate network."""
    print("\n=======================================================")
    print("🕸️  ModernizeIQ Network Graph Analytics Report")
    print("=======================================================")
    print(f"Nodes (Total Applications) : {g.number_of_nodes()}")
    print(f"Edges (Dependency Links)   : {g.number_of_edges()}")

    # Out-degree: how many systems does a single app depend on?
    out_degs = [d for _, d in g.out_degree()]
    print(f"Out-degree Distribution    : min={min(out_degs)} max={max(out_degs)} avg={sum(out_degs)/len(out_degs):.2f}")

    # In-degree: how many other systems depend on this specific app? (Blast Radius Proxy)
    in_degs = [d for _, d in g.in_degree()]
    print(f"In-degree Distribution     : min={min(in_degs)} max={max(in_degs)} avg={sum(in_degs)/len(in_degs):.2f}")

    # Connected components: Are there isolated island networks?
    components = list(nx.weakly_connected_components(g))
    print(f"Weakly Connected Components: {len(components)}  (Sizes: {sorted([len(c) for c in components], reverse=True)[:5]})")

    # Cycles: Are there dangerous circular loop dependencies? (e.g., A -> B -> C -> A)
    cycles = list(nx.simple_cycles(g))
    print(f"Circular Loops Detected    : {len(cycles)}")
    if cycles:
        print(f"  └─ Example cycle loop: {' -> '.join(cycles[0][:4])} -> ...")

    # Top 5 Blast-Radius Candidates
    top_in = sorted(g.in_degree(), key=lambda x: x[1], reverse=True)[:5]
    print("\n🏆 Top 5 Highest Blast-Radius Infrastructure Systems:")
    for node, deg in top_in:
        print(f"  [{deg:2d} downstream dependents] <- {node} ({g.nodes[node]['name']})")
    print("=======================================================\n")

def visualize_graph(g: nx.DiGraph):
    """Generates a physical layout map of the network and saves it to a PNG."""
    print("\n🎨 Rendering enterprise graph layout...")
    
    # Set up a large frame canvas size so 50 apps aren't cramped
    plt.figure(figsize=(14, 10))
    
    # Use a spring layout algorithm to automatically push nodes away from each other 
    # so clusters form naturally based on connections
    pos = nx.spring_layout(g, k=0.3, seed=42)
    
    # Pick a clean color map for the nodes
    nx.draw_networkx_nodes(
        g, pos, 
        node_size=180, 
        node_color="#1f77b4", 
        alpha=0.85
    )
    
    # Draw the directional dependency arrows
    nx.draw_networkx_edges(
        g, pos, 
        arrowstyle="->", 
        arrowsize=12, 
        edge_color="#cccccc", 
        width=1.0, 
        alpha=0.6
    )
    
    # Add truncated labels for high blast-radius systems so the image stays scannable
    labels = {node: g.nodes[node]['name'][:12] + '...' for node in g.nodes if g.in_degree(node) > 2}
    nx.draw_networkx_labels(g, pos, labels=labels, font_size=8, font_color="#333333")
    
    plt.title("ModernizeIQ — Synthetic Portfolio Dependency Graph Network Map", fontsize=14, fontweight='bold')
    plt.axis('off')
    
    # Save the output image file directly into your root directory
    output_path = "portfolio_graph.png"
    plt.savefig(output_path, bbox_inches='tight', dpi=300)
    plt.close()
    
    print(f"💾 Success! The visual graph map has been saved to: {os.path.abspath(output_path)}")
if __name__ == "__main__":
    g = build_graph()
    print_stats(g)
    visualize_graph(g)