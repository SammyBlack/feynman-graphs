K4w0 = NewFeynmanGraph({
	0:[1, 2, 3],
	1:[2, 3],
	2:[3]
	},
	name = 'K4w0'
	)
K4w0.label_edges()
K4w0.incl_verts = []
K4w0.excl_verts = []
K4w1 = NewFeynmanGraph({
	0:[1, 2, 3, 4],
	1:[2, 3, 4],
	2:[3],
	},
	name = 'K4w1'
	)
K4w1.label_edges()
K4w1.incl_verts = [(0, 4)]
K4w1.excl_verts = [(0, 1), (1, 4)]
K4w2 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 3, 4],
	2:[3, 5],
	},
	name = 'K4w2'
	)
K4w2.label_edges()
K4w2.incl_verts = [(0, 4), (0, 5)]
K4w2.excl_verts = [(0, 1), (1, 4), (0, 2), (2, 5)]
K4w3 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 3, 4],
	2:[3, 5],
	3:[6],
	},
	name = 'K4w3'
	)
K4w3.label_edges()
K4w3.incl_verts = [(0, 4), (0, 5), (0, 6)]
K4w3.excl_verts = [(0, 1), (1, 4), (0, 2), (2, 5), (0, 3), (3, 6)]
K4w4 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 3, 4, 7],
	2:[3, 5, 7],
	3:[6],
	},
	name = 'K4w4'
	)
K4w4.label_edges()
K4w4.incl_verts = [(0, 4), (0, 5), (0, 6), (1, 7)]
K4w4.excl_verts = [(0, 1), (1, 4), (0, 2), (2, 5), (0, 3), (3, 6), (1, 2), (2, 7)]
K4w5 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 3, 4, 7, 8],
	2:[3, 5, 7],
	3:[6, 8],
	},
	name = 'K4w5'
	)
K4w5.label_edges()
K4w5.incl_verts = [(0, 4), (0, 5), (0, 6), (1, 7), (1, 8)]
K4w5.excl_verts = [(0, 1), (1, 4), (0, 2), (2, 5), (0, 3), (3, 6), (1, 2), (2, 7), (1, 3), (3, 8)]
K4w6 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 3, 4, 6],
	2:[3, 5, 6],
	},
	name = 'K4w6'
	)
K4w6.label_edges()
K4w6.incl_verts = [(0, 4), (0, 5), (1, 6)]
K4w6.excl_verts = [(0, 1), (1, 4), (0, 2), (2, 5), (1, 2), (2, 6)]
K4w7 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 3, 4, 6],
	2:[3, 5],
	3:[6],
	},
	name = 'K4w7'
	)
K4w7.label_edges()
K4w7.incl_verts = [(0, 4), (0, 5), (1, 6)]
K4w7.excl_verts = [(0, 1), (1, 4), (0, 2), (2, 5), (1, 3), (3, 6)]
K4w8 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 3, 4, 6],
	2:[3, 5, 7],
	3:[6, 7],
	},
	name = 'K4w8'
	)
K4w8.label_edges()
K4w8.incl_verts = [(0, 4), (0, 5), (1, 6), (2, 7)]
K4w8.excl_verts = [(0, 1), (1, 4), (0, 2), (2, 5), (1, 3), (3, 6), (2, 3), (3, 7)]
K4w9 = NewFeynmanGraph({
	0:[1, 2, 3, 4],
	1:[2, 3, 4],
	2:[3, 5],
	3:[5],
	},
	name = 'K4w9'
	)
K4w9.label_edges()
K4w9.incl_verts = [(0, 4), (2, 5)]
K4w9.excl_verts = [(0, 1), (1, 4), (2, 3), (3, 5)]
K4w_list = [K4w0, K4w1, K4w2, K4w3, K4w4, K4w5, K4w6, K4w7, K4w8, K4w9]
