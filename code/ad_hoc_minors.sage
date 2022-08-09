def skeleton_minors(G):
    name = G.name().partition('n')[0]
    if name == 'W4':
        minors = []
    elif name == 'K5m':
        minors = K5m_to_W4(G)
    elif name == 'P':
        minors = P_to_W4(G)
    elif name == 'TU':    # Actually, this is P+.
        minors = TU_to_minors(G)
    elif name == 'D':
        minors = D_to_TU(G)
    elif name == 'H4':
        minors = H4_to_minors(G)
    else:
        minors = []
        print('Unexpected skeleton!')
    return minors

def del_widget(G_in, a, b):
    """Deletes the widget attached at vertices a, b."""
    G = copy(G_in)
    try:
        G.delete_multiedge(a, b)
    except(RuntimeError):
        pass
    nbrs = list(set(G.neighbors(a)).intersection(set(G.neighbors(b))))    # common neighbors of a, b
    for v in nbrs:
        if G.degree(v) == 2:
            G.delete_vertex(v)
    return G

def ctr_widget(G_in, a, b):
    """Contracts the widget attached at vertices a, b."""
    G = del_widget(G_in, a, b)
    G.merge_vertices([a, b])
    return G

def K5m_to_W4(G):
    """In a graph with a K5m skeleton, find the minors with a W4 skeleton.
    (Note:  this depends on the particular vertex ordering.)"""
    minors = []
    minors.extend([del_widget(G, a, b) for (a, b) in [(0, 1), (0, 3), (1, 3)]])
    return minors

def P_to_W4(G):
    """In a graph with a P skeleton, find the minors with a W4 skeleton.
    (Note:  this depends on the particular vertex ordering.)"""
    minors = []
    minors.extend([ctr_widget(G, a, b) for (a, b) in [(0, 3), (1, 4), (2, 5)]])
    return minors

def TU_to_minors(G):
    """In a graph with a TU skeleton, find the minors with a P or K5m skeleton.
    (Note:  this depends on the particular vertex ordering.)"""
    minors = []
    minors.append(del_widget(G, 0, 4))
    minors.append(ctr_widget(G, 2, 5))
    return minors

def D_to_TU(G):
    """In a graph with a D skeleton, find the minors with a TU skeleton.
    (Note:  this depends on the particular vertex ordering.)"""
    minors = []
    minors.extend([del_widget(G, a, b) for (a, b) in [(0, 2), (0, 3), (2, 5), (3, 5)]])
    return minors

def H4_to_minors(G):
    """In a graph with a H4 skeleton, find the minors with a TU or W5 skeleton.
    (Note:  this depends on the particular vertex ordering.)"""
    minors = []
    minors.extend([del_widget(G, a, b) for (a, b) in [(0, 4), (0, 5), (4, 5)]])
    return minors
