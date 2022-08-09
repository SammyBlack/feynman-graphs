# methods for NewFeynmanGraph class

    def triangles(self, edges=False):
        triangles = []
        for c in self.cliques_maximal():
            if len(c) >= 3:
                triangles.extend(combinations(c, 3))
        if edges:
            triangles = [[edge_from_vertices(self, *v) for v in combinations(t, 2)] for t in triangles]
        return triangles

    def ys(self, edges=False):
        ys = []
        for v in self.vertices():
            y = self.edges_incident(v)
            if len(y) == 3:
                if edges:
                    ys.append((v, [e[2] for e in y]))
                else:
                    ys.append((v, self.vertex_boundary([v])))
        return ys
        
    def tri_y_family(self, show=False, fam_log='DELETE_ME', write_edges=False):
        """Returns list of graphs in the triangle--Y transformation equivalence class."""
        write_self = self._repr_()
        if write_edges:
            log_edges_file = open(fam_log + '_edges', 'a')
            log_edges_file.write(str(self.edges()) + '\n')
            log_edges_file.close()
        log_file = open(fam_log, 'a')
        log_file.write(write_self + '\n\n')
        log_file.close()
        G = self.copy()
        G.name('G_0')
        fam = triangle_y_component([G], 0, comp_log=fam_log, write_edges=write_edges)
        if show:
            graphs_list.show_graphs(fam)
        return fam
                       
    def triangle_to_y(self, tri_verts, inplace=True):
        """Returns NewFeynmanGraph with triangle-to-Y transformation on given triple of vertices"""
        n = self.order()
        D = self.get_pos()
        if D:
            D = D.copy()
#        tri_verts = list(set(flatten([self.edge_to_verts(e) for e in tri_edges])))
        tri_edges = [G.edge_boundary([v0], [v1])[0] for (v0, v1) in combinations(tri_verts, 2)]
        for (v, e) in zip(tri_verts, tri_edges):
            self.delete_edge(e)
            self.add_edge((v, n, e[2]))
        if D:
            D[n] = map(mean, [[D[v][i] for v in tri_verts] for i in (0, 1)])
            self.set_pos(D)
        return

    def y_to_triangle(self, y_verts, verbose=False, inplace=True):
        """Returns Feynman graph with Y-to-triangle transformation on y_verts"""
        if verbose:
            print 'Originally: \n', self.edges()
        self.delete_vertex(y_verts[0])
        if verbose:
            print 'Y-center removed: \n', self.edges()
        self.add_edges(combinations(y_verts[1], 2))
        if verbose:
            print 'New tri: \n', self.edges()       
        self.label_edges()
        return
        
def triangle_y_component(family, pointer, comp_log='DELETE_ME', write_edges=False):
    """Generates entire family of graphs in triangle-Y equivalence class."""
    log_file = open(comp_log, 'a')
    log_edges_file = open(comp_log + '_edges', 'a')
    while pointer < len(family):
        G = family[pointer]
        tri = G.triangles()
        ys = G.ys()
        for t in tri:    # triangles
            Y = copy(G)
            Y.triangle_to_y(t)
            for H in reversed(family):
                if Y.is_isomorphic(H):
                    break
            else:
                Y.name('G_{k}'.format(k=len(family)))
                family.append(Y)
                tri_to_y = '{name}, from {parent}, using tri --> Y on verts: '.format(name=Y.name(), parent=G.name()) + ' ' + str(t)
                print tri_to_y
                log_file.write(tri_to_y + '\n')
                if write_edges:
                    log_edges_file.write(str(Y.edges()) + '\n')
            sys.stdout.flush()
        for y in ys:    # Y's
            T = copy(G)
            T.y_to_triangle(y)
            for H in reversed(family):
                if T.is_isomorphic(H):
                    break
            else:
                T.name('G_{k}'.format(k=len(family)))
                family.append(T)
                y_to_tri = '{name}, from {parent}, using Y --> tri at vertex: '.format(name=T.name(), parent=G.name()) + ' ' + str(y[0])
                print y_to_tri
                log_file.write(y_to_tri + '\n')
                if write_edges:
                    log_edges_file.write(str(T.edges()) + '\n')
            sys.stdout.flush()
        pointer += 1
    concl_str = 'This tri-Y family has {g} graphs.'.format(g = len(family))
    print concl_str
    log_file.write(concl_str + '\n')
    log_file.close()
    log_edges_file.close()
    return family
