K5mw0 = NewFeynmanGraph({
	0:[1, 2, 3, 4],
	1:[2, 4, 3],
	2:[3],
	3:[4]
	},
	name = 'K5mw0'
	)
K5mw0.label_edges()
K5mw0.incl_verts = []
K5mw0.excl_verts = []
K5mw1 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 4, 3, 5],
	2:[3],
	3:[4],
	},
	name = 'K5mw1'
	)
K5mw1.label_edges()
K5mw1.incl_verts = [(0, 5)]
K5mw1.excl_verts = [(0, 1), (1, 5)]
K5mw2 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5],
	2:[3, 6],
	3:[4],
	},
	name = 'K5mw2'
	)
K5mw2.label_edges()
K5mw2.incl_verts = [(0, 5), (0, 6)]
K5mw2.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6)]
K5mw3 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5],
	2:[3, 6],
	3:[4, 7],
	},
	name = 'K5mw3'
	)
K5mw3.label_edges()
K5mw3.incl_verts = [(0, 5), (0, 6), (0, 7)]
K5mw3.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7)]
K5mw4 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7, 8],
	1:[2, 4, 3, 5],
	2:[3, 6],
	3:[4, 7],
	4:[8],
	},
	name = 'K5mw4'
	)
K5mw4.label_edges()
K5mw4.incl_verts = [(0, 5), (0, 6), (0, 7), (0, 8)]
K5mw4.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (0, 4), (4, 8)]
K5mw5 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7, 8],
	1:[2, 4, 3, 5, 9],
	2:[3, 6, 9],
	3:[4, 7],
	4:[8],
	},
	name = 'K5mw5'
	)
K5mw5.label_edges()
K5mw5.incl_verts = [(0, 5), (0, 6), (0, 7), (0, 8), (1, 9)]
K5mw5.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (0, 4), (4, 8), (1, 2), (2, 9)]
K5mw6 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7, 8],
	1:[2, 4, 3, 5, 9],
	2:[3, 6],
	3:[4, 7, 9],
	4:[8],
	},
	name = 'K5mw6'
	)
K5mw6.label_edges()
K5mw6.incl_verts = [(0, 5), (0, 6), (0, 7), (0, 8), (1, 9)]
K5mw6.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (0, 4), (4, 8), (1, 3), (3, 9)]
K5mw7 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6, 8],
	3:[4, 7],
	},
	name = 'K5mw7'
	)
K5mw7.label_edges()
K5mw7.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8)]
K5mw7.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (1, 2), (2, 8)]
K5mw8 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8, 9],
	2:[3, 6, 8],
	3:[4, 7],
	4:[9],
	},
	name = 'K5mw8'
	)
K5mw8.label_edges()
K5mw8.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8), (1, 9)]
K5mw8.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (1, 2), (2, 8), (1, 4), (4, 9)]
K5mw9 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8, 9],
	2:[3, 6, 8],
	3:[4, 7, 9],
	},
	name = 'K5mw9'
	)
K5mw9.label_edges()
K5mw9.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8), (1, 9)]
K5mw9.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (1, 2), (2, 8), (1, 3), (3, 9)]
K5mw10 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6, 8, 9],
	3:[4, 7, 9],
	},
	name = 'K5mw10'
	)
K5mw10.label_edges()
K5mw10.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8), (2, 9)]
K5mw10.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (1, 2), (2, 8), (2, 3), (3, 9)]
K5mw11 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6, 8],
	3:[4, 7, 9],
	4:[9],
	},
	name = 'K5mw11'
	)
K5mw11.label_edges()
K5mw11.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8), (3, 9)]
K5mw11.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (1, 2), (2, 8), (3, 4), (4, 9)]
K5mw12 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6],
	3:[4, 7],
	4:[8],
	},
	name = 'K5mw12'
	)
K5mw12.label_edges()
K5mw12.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8)]
K5mw12.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (1, 4), (4, 8)]
K5mw13 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8, 9],
	2:[3, 6],
	3:[4, 7, 9],
	4:[8],
	},
	name = 'K5mw13'
	)
K5mw13.label_edges()
K5mw13.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8), (1, 9)]
K5mw13.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (1, 4), (4, 8), (1, 3), (3, 9)]
K5mw14 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6],
	3:[4, 7, 9],
	4:[8, 9],
	},
	name = 'K5mw14'
	)
K5mw14.label_edges()
K5mw14.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8), (3, 9)]
K5mw14.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (1, 4), (4, 8), (3, 4), (4, 9)]
K5mw15 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6],
	3:[4, 7, 8],
	},
	name = 'K5mw15'
	)
K5mw15.label_edges()
K5mw15.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8)]
K5mw15.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 3), (3, 7), (1, 3), (3, 8)]
K5mw16 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5],
	2:[3, 6],
	3:[4],
	4:[7],
	},
	name = 'K5mw16'
	)
K5mw16.label_edges()
K5mw16.incl_verts = [(0, 5), (0, 6), (0, 7)]
K5mw16.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 4), (4, 7)]
K5mw17 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6, 8],
	3:[4],
	4:[7],
	},
	name = 'K5mw17'
	)
K5mw17.label_edges()
K5mw17.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8)]
K5mw17.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 4), (4, 7), (1, 2), (2, 8)]
K5mw18 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8, 9],
	2:[3, 6, 8],
	3:[4],
	4:[7, 9],
	},
	name = 'K5mw18'
	)
K5mw18.label_edges()
K5mw18.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8), (1, 9)]
K5mw18.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 4), (4, 7), (1, 2), (2, 8), (1, 4), (4, 9)]
K5mw19 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6, 8, 9],
	3:[4, 9],
	4:[7],
	},
	name = 'K5mw19'
	)
K5mw19.label_edges()
K5mw19.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8), (2, 9)]
K5mw19.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 4), (4, 7), (1, 2), (2, 8), (2, 3), (3, 9)]
K5mw20 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6, 8],
	3:[4, 9],
	4:[7, 9],
	},
	name = 'K5mw20'
	)
K5mw20.label_edges()
K5mw20.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8), (3, 9)]
K5mw20.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 4), (4, 7), (1, 2), (2, 8), (3, 4), (4, 9)]
K5mw21 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6],
	3:[4, 8],
	4:[7],
	},
	name = 'K5mw21'
	)
K5mw21.label_edges()
K5mw21.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8)]
K5mw21.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 4), (4, 7), (1, 3), (3, 8)]
K5mw22 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5, 8],
	2:[3, 6, 9],
	3:[4, 8, 9],
	4:[7],
	},
	name = 'K5mw22'
	)
K5mw22.label_edges()
K5mw22.incl_verts = [(0, 5), (0, 6), (0, 7), (1, 8), (2, 9)]
K5mw22.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 4), (4, 7), (1, 3), (3, 8), (2, 3), (3, 9)]
K5mw23 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5],
	2:[3, 6, 8],
	3:[4, 8],
	4:[7],
	},
	name = 'K5mw23'
	)
K5mw23.label_edges()
K5mw23.incl_verts = [(0, 5), (0, 6), (0, 7), (2, 8)]
K5mw23.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 4), (4, 7), (2, 3), (3, 8)]
K5mw24 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6, 7],
	1:[2, 4, 3, 5],
	2:[3, 6, 8],
	3:[4, 8, 9],
	4:[7, 9],
	},
	name = 'K5mw24'
	)
K5mw24.label_edges()
K5mw24.incl_verts = [(0, 5), (0, 6), (0, 7), (2, 8), (3, 9)]
K5mw24.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (0, 4), (4, 7), (2, 3), (3, 8), (3, 4), (4, 9)]
K5mw25 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3, 6, 7],
	3:[4],
	},
	name = 'K5mw25'
	)
K5mw25.label_edges()
K5mw25.incl_verts = [(0, 5), (0, 6), (1, 7)]
K5mw25.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (1, 2), (2, 7)]
K5mw26 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3, 6, 7, 8],
	3:[4, 8],
	},
	name = 'K5mw26'
	)
K5mw26.label_edges()
K5mw26.incl_verts = [(0, 5), (0, 6), (1, 7), (2, 8)]
K5mw26.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (1, 2), (2, 7), (2, 3), (3, 8)]
K5mw27 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3, 6, 7, 8],
	3:[4, 8, 9],
	4:[9],
	},
	name = 'K5mw27'
	)
K5mw27.label_edges()
K5mw27.incl_verts = [(0, 5), (0, 6), (1, 7), (2, 8), (3, 9)]
K5mw27.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (1, 2), (2, 7), (2, 3), (3, 8), (3, 4), (4, 9)]
K5mw28 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3, 6, 7],
	3:[4, 8],
	4:[8],
	},
	name = 'K5mw28'
	)
K5mw28.label_edges()
K5mw28.incl_verts = [(0, 5), (0, 6), (1, 7), (3, 8)]
K5mw28.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (1, 2), (2, 7), (3, 4), (4, 8)]
K5mw29 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3, 6],
	3:[4],
	4:[7],
	},
	name = 'K5mw29'
	)
K5mw29.label_edges()
K5mw29.incl_verts = [(0, 5), (0, 6), (1, 7)]
K5mw29.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (1, 4), (4, 7)]
K5mw30 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3, 6, 8],
	3:[4, 8],
	4:[7],
	},
	name = 'K5mw30'
	)
K5mw30.label_edges()
K5mw30.incl_verts = [(0, 5), (0, 6), (1, 7), (2, 8)]
K5mw30.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (1, 4), (4, 7), (2, 3), (3, 8)]
K5mw31 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3, 6, 8],
	3:[4, 8, 9],
	4:[7, 9],
	},
	name = 'K5mw31'
	)
K5mw31.label_edges()
K5mw31.incl_verts = [(0, 5), (0, 6), (1, 7), (2, 8), (3, 9)]
K5mw31.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (1, 4), (4, 7), (2, 3), (3, 8), (3, 4), (4, 9)]
K5mw32 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3, 6],
	3:[4, 7],
	},
	name = 'K5mw32'
	)
K5mw32.label_edges()
K5mw32.incl_verts = [(0, 5), (0, 6), (1, 7)]
K5mw32.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (1, 3), (3, 7)]
K5mw33 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3, 6, 8],
	3:[4, 7, 8],
	},
	name = 'K5mw33'
	)
K5mw33.label_edges()
K5mw33.incl_verts = [(0, 5), (0, 6), (1, 7), (2, 8)]
K5mw33.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (1, 3), (3, 7), (2, 3), (3, 8)]
K5mw34 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3, 6],
	3:[4, 7, 8],
	4:[8],
	},
	name = 'K5mw34'
	)
K5mw34.label_edges()
K5mw34.incl_verts = [(0, 5), (0, 6), (1, 7), (3, 8)]
K5mw34.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (1, 3), (3, 7), (3, 4), (4, 8)]
K5mw35 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5],
	2:[3, 6, 7],
	3:[4, 7],
	},
	name = 'K5mw35'
	)
K5mw35.label_edges()
K5mw35.incl_verts = [(0, 5), (0, 6), (2, 7)]
K5mw35.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (2, 3), (3, 7)]
K5mw36 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5],
	2:[3, 6, 7],
	3:[4, 7, 8],
	4:[8],
	},
	name = 'K5mw36'
	)
K5mw36.label_edges()
K5mw36.incl_verts = [(0, 5), (0, 6), (2, 7), (3, 8)]
K5mw36.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (2, 3), (3, 7), (3, 4), (4, 8)]
K5mw37 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5],
	2:[3, 6],
	3:[4, 7],
	4:[7],
	},
	name = 'K5mw37'
	)
K5mw37.label_edges()
K5mw37.incl_verts = [(0, 5), (0, 6), (3, 7)]
K5mw37.excl_verts = [(0, 1), (1, 5), (0, 2), (2, 6), (3, 4), (4, 7)]
K5mw38 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5],
	2:[3],
	3:[4, 6],
	},
	name = 'K5mw38'
	)
K5mw38.label_edges()
K5mw38.incl_verts = [(0, 5), (0, 6)]
K5mw38.excl_verts = [(0, 1), (1, 5), (0, 3), (3, 6)]
K5mw39 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 5, 7],
	2:[3],
	3:[4, 6, 7],
	},
	name = 'K5mw39'
	)
K5mw39.label_edges()
K5mw39.incl_verts = [(0, 5), (0, 6), (1, 7)]
K5mw39.excl_verts = [(0, 1), (1, 5), (0, 3), (3, 6), (1, 3), (3, 7)]
K5mw40 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 4, 3, 5],
	2:[3, 6],
	3:[4, 6],
	},
	name = 'K5mw40'
	)
K5mw40.label_edges()
K5mw40.incl_verts = [(0, 5), (2, 6)]
K5mw40.excl_verts = [(0, 1), (1, 5), (2, 3), (3, 6)]
K5mw41 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 4, 3, 5],
	2:[3, 6],
	3:[4, 6, 7],
	4:[7],
	},
	name = 'K5mw41'
	)
K5mw41.label_edges()
K5mw41.incl_verts = [(0, 5), (2, 6), (3, 7)]
K5mw41.excl_verts = [(0, 1), (1, 5), (2, 3), (3, 6), (3, 4), (4, 7)]
K5mw42 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 4, 3],
	2:[3, 5],
	3:[4],
	},
	name = 'K5mw42'
	)
K5mw42.label_edges()
K5mw42.incl_verts = [(0, 5)]
K5mw42.excl_verts = [(0, 2), (2, 5)]
K5mw43 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3],
	2:[3, 5],
	3:[4],
	4:[6],
	},
	name = 'K5mw43'
	)
K5mw43.label_edges()
K5mw43.incl_verts = [(0, 5), (0, 6)]
K5mw43.excl_verts = [(0, 2), (2, 5), (0, 4), (4, 6)]
K5mw44 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 7],
	2:[3, 5, 7],
	3:[4],
	4:[6],
	},
	name = 'K5mw44'
	)
K5mw44.label_edges()
K5mw44.incl_verts = [(0, 5), (0, 6), (1, 7)]
K5mw44.excl_verts = [(0, 2), (2, 5), (0, 4), (4, 6), (1, 2), (2, 7)]
K5mw45 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 7, 8],
	2:[3, 5, 7],
	3:[4],
	4:[6, 8],
	},
	name = 'K5mw45'
	)
K5mw45.label_edges()
K5mw45.incl_verts = [(0, 5), (0, 6), (1, 7), (1, 8)]
K5mw45.excl_verts = [(0, 2), (2, 5), (0, 4), (4, 6), (1, 2), (2, 7), (1, 4), (4, 8)]
K5mw46 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 7, 8],
	2:[3, 5, 7, 9],
	3:[4, 9],
	4:[6, 8],
	},
	name = 'K5mw46'
	)
K5mw46.label_edges()
K5mw46.incl_verts = [(0, 5), (0, 6), (1, 7), (1, 8), (2, 9)]
K5mw46.excl_verts = [(0, 2), (2, 5), (0, 4), (4, 6), (1, 2), (2, 7), (1, 4), (4, 8), (2, 3), (3, 9)]
K5mw47 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 7],
	2:[3, 5, 7, 8],
	3:[4, 8],
	4:[6],
	},
	name = 'K5mw47'
	)
K5mw47.label_edges()
K5mw47.incl_verts = [(0, 5), (0, 6), (1, 7), (2, 8)]
K5mw47.excl_verts = [(0, 2), (2, 5), (0, 4), (4, 6), (1, 2), (2, 7), (2, 3), (3, 8)]
K5mw48 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5, 6],
	1:[2, 4, 3, 7],
	2:[3, 5, 7],
	3:[4, 8],
	4:[6, 8],
	},
	name = 'K5mw48'
	)
K5mw48.label_edges()
K5mw48.incl_verts = [(0, 5), (0, 6), (1, 7), (3, 8)]
K5mw48.excl_verts = [(0, 2), (2, 5), (0, 4), (4, 6), (1, 2), (2, 7), (3, 4), (4, 8)]
K5mw49 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 4, 3, 6],
	2:[3, 5, 6],
	3:[4],
	},
	name = 'K5mw49'
	)
K5mw49.label_edges()
K5mw49.incl_verts = [(0, 5), (1, 6)]
K5mw49.excl_verts = [(0, 2), (2, 5), (1, 2), (2, 6)]
K5mw50 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 4, 3, 6],
	2:[3, 5, 6, 7],
	3:[4, 7],
	},
	name = 'K5mw50'
	)
K5mw50.label_edges()
K5mw50.incl_verts = [(0, 5), (1, 6), (2, 7)]
K5mw50.excl_verts = [(0, 2), (2, 5), (1, 2), (2, 6), (2, 3), (3, 7)]
K5mw51 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 4, 3, 6],
	2:[3, 5, 6],
	3:[4, 7],
	4:[7],
	},
	name = 'K5mw51'
	)
K5mw51.label_edges()
K5mw51.incl_verts = [(0, 5), (1, 6), (3, 7)]
K5mw51.excl_verts = [(0, 2), (2, 5), (1, 2), (2, 6), (3, 4), (4, 7)]
K5mw52 = NewFeynmanGraph({
	0:[1, 2, 3, 4, 5],
	1:[2, 4, 3, 6],
	2:[3, 5],
	3:[4],
	4:[6],
	},
	name = 'K5mw52'
	)
K5mw52.label_edges()
K5mw52.incl_verts = [(0, 5), (1, 6)]
K5mw52.excl_verts = [(0, 2), (2, 5), (1, 4), (4, 6)]
K5mw_list = [K5mw0, K5mw1, K5mw2, K5mw3, K5mw4, K5mw5, K5mw6, K5mw7, K5mw8, K5mw9, K5mw10, K5mw11, K5mw12, K5mw13, K5mw14, K5mw15, K5mw16, K5mw17, K5mw18, K5mw19, K5mw20, K5mw21, K5mw22, K5mw23, K5mw24, K5mw25, K5mw26, K5mw27, K5mw28, K5mw29, K5mw30, K5mw31, K5mw32, K5mw33, K5mw34, K5mw35, K5mw36, K5mw37, K5mw38, K5mw39, K5mw40, K5mw41, K5mw42, K5mw43, K5mw44, K5mw45, K5mw46, K5mw47, K5mw48, K5mw49, K5mw50, K5mw51, K5mw52]