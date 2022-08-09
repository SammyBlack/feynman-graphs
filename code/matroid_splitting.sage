#! /usr/bin/env sage

# Last modified on 2013/06/04

from sage.graphs.graph import Graph

class NewFeynmanGraph(Graph):
    def __init__(self, *args, **kwds):
        """Initialize self as graph that allows multiple edges and loops."""
        Graph.__init__(self,  *args, **kwds)
        self.allow_multiple_edges(True)
        self.allow_loops(True)
        self.F = None           # five configuration
        self.F_splits = None    # five configuration splits
        self.splits = None      # graph splits for all five configurations
        self.comps = None       # list of connected components (to be filled)
        self.incl_verts = []    # vertex pairs to be explicitly included
        self.excl_verts = []    # vertex pairs to be explicitly excluded
        self.incl = []          # edge labels to be explicitly included
        self.excl = []          # edge labels to be explicitly excluded
        self.skel = ''          # skeleton
        from sys import stdout

    def _repr_(self):
        """String representation of self"""
        name = 'New Feynman graph with {E} edges on {V} vert'
        if self.name() != '':  name = self.name() + ':  ' + name
        if self.order() == 1:  name += 'ex'
        else:  name += 'ices'
        name = name.format(E=self.size(), V=self.order())
        return name

    def show(self, *args, **kwds):
        """Show self with edge labels."""
        Graph.show(self, *args, edge_labels=True, axes_pad=0.1, **kwds)

    def label_edges(self, inplace=True):
        """Relabel vertices with range(order(G)) and edges with range(size(G))."""
        if inplace:
            self.relabel(inplace=True)
            new_edges=[(e[0], e[1], k) for (k, e) in enumerate(self.edges())]
            self.delete_edges(self.edges())
            self.delete_edges(self.edges())    # WTF!
            self.add_edges(new_edges)
            self.incl_excl_verts_to_labels()
            return
        else:
            H = self.relabel(inplace=False)
            H_edges=[(e[0], e[1], k) for k,e in enumerate(H.edges())]
            H = NewFeynmanGraph()
            H.add_edges(H_edges)
            H.incl_excl_verts_to_labels()
            return H

    def edge_to_verts(self, e, label=False):
        """Look up source and target vertices for edge e in graph self, returning None if it doesn't exist."""
        for f in self.edges():
            if f[2] == e:
                if label:
                    return f
                else:
                    return f[:2]
        else:
            return None

    def verts_to_edge(a, b):
        pass

    def isom_in(self, graph_list):
        for H in graph_list:
            if self.is_isomorphic(H):
                return True
        return False

    def write_to_file(self, basename=''):
        s = self.size()
        filename = basename + '_' + str(s)
        with open(filename, 'a') as f:
            f.write(' '.join(['{a}-{b}'.format(a=e[0], b=e[1]) for e in self.edges()]) + '\n')

    def trivial_split_cycle(self, F=None):
        """Assigns Boolean value of whether a k-edge cycle (k <= 3) exists in five configuration F and returns edges."""
        if F:    # use five configuration F, if given
            self.F = F
            self.F_splits = None
        f = [self.edge_to_verts(e, label=True) for e in self.F]
        for e0 in f:              # single edge
            if e0[0] == e0[1]:    # loop
                self.F_splits = True
                return ((e0[2]), 'cycle')
        else:
            self.F_splits = False
        for e0 in f:              # edge 0
            f0 = f[:]
            f0.remove(e0)
            for e1 in f0:         # edge 1
                if len(set(e0[:2] + e1[:2])) == 2:    # bigon
                    self.F_splits = True
                    return ((e0[2], e1[2]), 'cycle')
        else:
            self.F_splits = False
        for e0 in f:              # edge 0
            f0 = f[:]
            f0.remove(e0)
            for e1 in f0:         # edge 1
                f1 = f0[:]
                f1.remove(e1)
                for e2 in f1:     # edge 2
                    if len(set(e0[:2] + e1[:2] + e2[:2])) == 3:    # triangle
                        self.F_splits = True
                        return ((e0[2], e1[2], e2[2]), 'cycle')
        else:
            return None
    
    def trivial_split_edge_cut(self, F=None):
        """Assigns Boolean value of whether a k-edge cut (k <= 3) exists in five configuration F and returns edges."""
        if F:    # use five configuration F, if given
            self.F = F
            self.F_splits = None
        f = [self.edge_to_verts(e, label=True) for e in self.F]    # convert 5-config edges to form:  (v_out, v_in, label)
        for e0 in f:    # edge 0
            g = copy(self)
            g.delete_edge(e0)
            if not g.is_connected():    # 1-edge cut
                self.F_splits = True
                return ((e0[2]), 'edge cut')
        for e0 in f:         # edge 0
            f0 = f[:]
            f0.remove(e0)
            for e1 in f0:    # edge 1
                g = copy(self)
                g.delete_edges([e0, e1])
                if not g.is_connected():    # 2-edge cut
                    self.F_splits = True
                    return((e0[2], e1[2]), 'edge cut')
        for e0 in f:             # edge 0
            f0 = f[:]
            f0.remove(e0)
            for e1 in f0:        # edge 1
                f1 = f0[:]
                f1.remove(e1)
                for e2 in f1:    # edge 2
                    g = copy(self)
                    g.delete_edges([e0, e1, e2])
                    if not g.is_connected():    # 2-edge cut
                        self.F_splits = True
                        return((e0[2], e1[2]), 'edge cut')
        else:
            return None

    def split_vertex_cut(self, F=None):
        """Assigns Boolean value of whether a vertex-cut splitting happens from five configuration F and returns edges."""
        if F:    # use five configuration F, if given
            self.F = F
            self.F_splits = None
        f = [self.edge_to_verts(e, label=True) for e in self.F]
        for e in f:
            g = copy(self)
            g.delete_edge(e)
            four = self.F[:]
            four.remove(e[2])
            for (v0, v1) in combinations_iterator(g.vertices(), 2):    # 2 vertices
                h = copy(g)
                h.delete_vertices([v0, v1])
                v = h.order() + 1
                for ee in f:    # reattach 5-configuration edges
                    if ee == e:    # edge e was deleted earlier so don't consider it
                        continue
                    for i in (0, 1):
                        if ee[i] in (v0, v1):    # vertex of edge ee was deleted
                            v += 1
                            h.add_vertex(v)
                            if ee[1 - i] in (v0, v1):    # other vertex of edge ee was deleted
                                v += 1
                                h.add_vertex(v)
                                h.add_edge((v - 1, v, ee[2]))    # new island edge
                            else:    # other vertex of edge ee was not deleted
                                h.add_edge((ee[1 - i], v, ee[2]))    # new peninsula edge
                comps = h.connected_components_subgraphs()    # list of connected components
                if len(comps) >= 2:    # (v0, v1) was a vertex split
                    comp_indices = [h.comp_index(ee, comps) for ee in four] # list of component indices for each edge in four
                    comp_indices_counts = tally(comp_indices)    # counts of five config edges in components
                    if max(comp_indices_counts.values()) <= 2:
                        self.F_splits = True
                        return (e[2], 'cut')
        else:
            return None

    def split_vertex_contract(self, F=None):
        """Assigns Boolean value of whether a vertex-contraction splitting happens from five configuration F and returns edges."""
        if F:    # use five configuration F, if given
            self.F = F
            self.F_splits = None
        f = [self.edge_to_verts(e, label=True) for e in self.F]
        for e in f:
            g = copy(self)
            g.contract_edge(e)
            four = self.F[:]
            four.remove(e[2])
            f_new = [g.edge_to_verts(eee, label=True) for eee in four]
            for (v0, v1) in combinations_iterator(g.vertices(), 2):    # 2 vertices
                h = copy(g)
                h.delete_vertices([v0, v1])
                v = h.order() + 2
                for ee in f_new:    # reattach 5-configuration edges
#                    if ee == e:    # edge e was contracted earlier so don't consider it
#                        continue
                    for i in (0, 1):
                        if ee[i] in (v0, v1):    # vertex of edge ee was deleted
                            v += 1
                            h.add_vertex(v)
                            if ee[1 - i] in (v0, v1):    # other vertex of edge ee was deleted
                                v += 1
                                h.add_vertex(v)
                                h.add_edge((v - 1, v, ee[2]))    # new island edge
                            else:    # other vertex of edge ee was not deleted
                                h.add_edge((ee[1 - i], v, ee[2]))    # new peninsula edge
                comps = h.connected_components_subgraphs()    # list of connected components
                if len(comps) >= 2:    # (v0, v1) was a vertex split
                    comp_indices = [h.comp_index(ee, comps) for ee in four] # list of component indices for each edge in four
                    comp_indices_counts = tally(comp_indices)    # counts of five config edges in components
                    if max(comp_indices_counts.values()) <= 2:
                        self.F_splits = True
                        return (e[2], 'contract')
        else:
            return None

    def split_for_five_config(self, F=None, verbose=False):
        if F:    # use five configuration F, if given
            self.F = F
            self.F_splits = False
        if verbose:
            print(' Checking trivial edge cycle splitting.')
        how_split = self.trivial_split_cycle()
        if how_split:
            if verbose:
                print('Does split: ', how_split)
            return (F, how_split)
        if verbose:
            print('  Checking trivial edge cut splitting.')
        how_split = self.trivial_split_edge_cut()
        if how_split:
            if verbose:
                print('Does split: ', how_split)
            return (F, how_split)
        if verbose:
            print('   Checking vertex cut splitting with edge cut.')
        how_split = self.split_vertex_cut()
        if how_split:
            if verbose:
                print('Does split: ', how_split)
            return (F, how_split)
        if verbose:
            print('    Checking vertex cut splitting with edge contraction.')
        how_split = self.split_vertex_contract()
        if how_split:
            if verbose:
                print('Does split: ', how_split)
            return (F, how_split)
        self.F_splits = False
        if verbose:
            print('Does not split! ')
        return (self.F, None)

    def split_for_any_five(self, including=[], excluding=[], verbose=False):
        """Find first instance of configurations of five edges for which some Dodgson does not split"""
        if not including:
            including = self.incl
        if not excluding:
            excluding = self.excl
        excluding = list(set(excluding).difference(set(including)))
        edges = self.size() - len(excluding) - len(including)
        var_edges = 5 - len(including)
        ex_inc = 'Excluding:  {ex}\nIncluding:  {inc}'.format(ex=excluding, inc=including)
        print(ex_inc)
        f_size = binomial(edges, var_edges)
        if f_size:
            f_str_size = len(str(f_size))
        print('Testing ({E} choose {vE}) = {fs} configurations:    '.format(E=edges, vE=var_edges, fs=f_size))
        E = sorted([edg[2] for edg in self.edges()])
        for e in including:
            E.remove(e)
        for e in excluding:
            E.remove(e)
        Fs = combinations(E, var_edges)
        f = 0
        for F in Fs:
            f += 1
            print('\b.',)
            sys.stdout.flush()
            F.extend(including)
            if verbose:
                print
                print('  '.join([str(f).rjust(f_str_size), str(F), '\n']))
            if not self.split_for_five_config(F)[1]:
                self.splits = False
                print('*',)
                break
        else:
            F = None
            self.splits = True
            self.F = None
            self.F_splits = None
            if verbose:
                print
                print('Does split for all five configurations.')
            return None
        return F
            
    def comp_index(self, e, comps):
        """Returns component number of edge e."""
        for (n, comp) in enumerate(comps):
            for ce in comp.edges():
                if ce[2] == e:
                    return n
        else:
            return None

    def contract_edge(self, e):
        """Contract give edge by merging endpoints, converting edges parallel to given edge into loops."""
        (v0, v1) = sorted(e[:2])
        self.delete_edge(e)
        multiple_edges = [(v0, v0, ed[2]) for ed in self.edges() if sorted(ed[:2]) == (v0, v1)]
        self.merge_vertices((v0, v1))
        self.add_edges(multiple_edges)

    def has_minor(self, H):
        """Returns Boolean whether H is a minor"""
        try:
            if self.minor(H):
                return True
        except(ValueError):
            return False

    def incl_excl_verts_to_labels(self, overwrite=True):
        """Assigns lists self.incl and self.excl from pairs of endpoints."""
        edges = self.edges()
        if overwrite:
            self.incl = []
            self.excl = []
        for incl_pair in self.incl_verts:
            for e in edges:
                if incl_pair == e[:2]:
                    self.incl.append(e[2])
                    edges.remove(e)
                    break
        for excl_pair in self.excl_verts:
            for e in edges:
                if excl_pair == e[:2]:
                    self.excl.append(e[2])
                    edges.remove(e)
                    break
        return
            
def read_from_file(filename, sep=' '):
    """Returns NewFeynmanGraph from edge data in a file"""
    skel_name = filename.partition('_')[0]
    with open(filename, 'r') as f:
        graphs_list = []
        for edges_string in f:
            edges_list = []
            for e in edges_string.split(sep):
                edges_list.append(tuple(map(int, e.split('-'))))
            g = NewFeynmanGraph()
            g.add_edges(edges_list)
            g.label_edges()
            g.skel = skel_name
            graphs_list.append(g)
    return graphs_list

def tally(L):
    """Returns dictionary consisting of multiset tally of L."""
    D = {}
    for l in L:
        if D.has_key(l):
            D[l] = D[l] + 1
        else:
            D[l] = 1
    return D

def test_list_for_split(L, show=True, write_to=''):
    split_results = []
    nonsplits = []
    with open(write_to, 'a') as f:
        for H in L:
            print
            print(H.name()            )
            H.split_for_any_five()
            split_results.append((H.name(), H.splits, H.F))
            f.write(str(H.name()).rjust(7) + ':  ' + str(H.splits).rjust(5) + '  ' + str(H.F) + '\n')
            if H.splits == False:
                nonsplits.append(H.name())
    if show:
        print('\n\n' + 40*'*' + '\nRESULTS\n')
        for H in split_results:
            print(H[0]+':', str(H[1]).rjust(5), H[2])
        print
        print('Nonsplits: ', nonsplits)
    else:
        print
    return split_results

def test_lists_for_split_with_minor_check(Lol, known_nonsplits=[], known_minimal_nonsplits=[], start_at=None, show=True, write_to=''):
    """Flatten list of lists.  Sort by number of edges.  Loop through, checking for known minors.  Appending to nonsplits if new."""
    split_results = []
    nonsplits = known_nonsplits   # begin with known nonsplit graphs
    minimal_nonsplits = known_minimal_nonsplits   # begin with known minimal nonsplit graphs
    L = sorted(flatten(Lol), key=lambda G: G.size())    # flat list of ALL graph with the same skeleton
    if start_at:    # start the loop somewhere other than at the beginning
        try:
            L_names = [GG.name() for GG in L]
            l = L_names.index(start_at)
        except(ValueError):
            print('Cannot find graph {g}.'.format(g=start_at))
            return
        L = L[l:]
    with open(write_to, 'a') as f:
        length = len(L)
        for (counter, H) in enumerate(L):    # loop through ALL graphs with same skeleton
            H.skel = H.name().partition('n')[0]    # set skeleton family for H from its name
            print
            print(H.name(), '({c} of {tot})'.format(c=counter, tot=length))
            if H.isom_in(nonsplits):
                nonsplits.append(H)
                H.splits = False
                H.F = 'iso'
            else:
                Ms = skeleton_minors(H)
                for M in Ms:
                    if M.isom_in(nonsplits):
                        nonsplits.append(H)
                        H.splits = False
                        H.F = 'minor'
                        break
                else:
                    for e in H.incl:
                        (a,b) = H.edge_to_verts(e)
                        if (a, b, e) in H.multiple_edges():   # d-widget
                            K = copy(H)
                            K.delete_edge((a, b, e))
                            if K.isom_in(nonsplits):    # WRITE self.isom_in(graph_list)
                                nonsplits.append(H)
                                H.splits = False
                                H.F = 'minor'
                                break
                        else:                       # c- or cd-widget
                            if H.degree(a) == 2:    # find 2-valent vertex
                                (ap, bp) = (b, a)
                            else:
                                (ap, bp) = (a, b)
                            edge_nbrs = H.edge_boundary([bp])
                            edge_nbrs.remove((a, b, e))
                            K = copy(H)
                            K.contract_edge(edge_nbrs[0])
                            if K.isom_in(nonsplits):
                                nonsplits.append(H)
                                H.splits = False
                                H.F = 'minor'
                                break
                            cp = H.neighbors(bp)
                            cp.remove(ap)
                            cp = cp[0]
                            ac = H.edge_boundary([ap], [cp])
                            if ac:    # cd-widget
                                K = copy(H)
                                K.delete_edge(ac[0])
                                if K.isom_in(nonsplits):
                                    nonsplits.append(H)
                                    H.splits = False
                                    H.F = 'minor'
                                    break
                    else:    # none of the minors from reducing widgets were nonsplit                
                        H.split_for_any_five()
                        if not H.splits:
                            nonsplits.append(H)
                            minimal_nonsplits.append(H)
            f.write(H.name() + ':  ' + str(H.splits).rjust(5) + '  ' + str(H.F) + '\n')
            if not H.splits:
                H.write_to_file(basename=H.skel + '_ns')
                if type(H.F) == list:
                    H.write_to_file(basename=H.skel + '_min_ns')
            split_results.append((H.name(), H.splits, H.F))
    if show:
        print('\n\n' + 40*'*' + '\nRESULTS\n')
        for H in split_results:
            print(H[0]+':', str(H[1]).rjust(5), H[2])
        print
        print('Minimal nonsplits: ', [H.name() for H in minimal_nonsplits])
    else:
        print
    return (nonsplits, minimal_nonsplits)

def get_phase_2_family_indices(Lol):
    i = Lol[0][0].name().index('n')
    print(i + 1)
    return [int(f[0].name()[i+1:-2]) for f in Lol]

def test_phase_2_families(Lol):
    graph_name = Lol[0][0].name()[:-2]
    i = graph_name.index('n')
    family_name = graph_name[:i]
    for f in Lol:
        filename = '{fam}/{fam}_phase2_{n}_results'.format(fam=family_name, n=f[0].name()[i+1:-2])
        print(10*'\n', filename)
        test_list_for_split(f, write_to=filename)
    return

def read_phase2_out(filename):
    with open(filename, 'r') as f:
        mins = []
        for l in f.readlines():
            L = l.split('  ')
            if L[2][0] == '[':
                mins.append((L[0][:-1], [int(n) for n in L[2][1:-2].split(', ')]))
    return mins

attach('ad_hoc_minors.sage')
