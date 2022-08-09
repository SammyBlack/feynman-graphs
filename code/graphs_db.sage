#! /usr/local/bin/sage

# Last modified 16 April, 2013

Samosa = NewFeynmanGraph({
    0:[1, 5, 6, 7],
    1:[2],
    2:[3, 6, 7],
    3:[4],
    4:[5, 6, 7]
    },
    name = 'Samosa'
    )
Samosa.label_edges()
Samosa.splits = False
Samosa.F = [0, 1, 2, 3, 5]

Rocket = NewFeynmanGraph({
    0:[1, 4, 5],
    1:[2],
    2:[3, 6, 6],
    3:[4, 7, 7],
    5:[6, 7],
    6:[7]
    },
    name = 'Rocket'
    )
Rocket.label_edges()
Rocket.splits = False
Rocket.F = [0, 1, 5, 8, 10]
    
Arugula = NewFeynmanGraph({
    0:[1, 2, 4, 5],
    1:[3],
    2:[4, 6, 6],
    3:[4, 7, 7],
    5:[6, 7],
    6:[7]
    },
    name = 'Arugula'
    )
Arugula.label_edges()
Arugula.splits = True

Pinwheel = NewFeynmanGraph({
    0:[1, 3, 4, 6],
    1:[2, 4],
    2:[3, 5],
    4:[7, 7],
    5:[6, 7, 7],
    6:[7, 7]
    },
    name = 'Pinwheel'
    )
Pinwheel.label_edges()
Pinwheel.splits = False
Pinwheel.F = [0, 1, 8, 11, 13]

Flower = NewFeynmanGraph({
    0:[1, 1, 2, 2, 3, 3],
    1:[2, 6],
    2:[4],
    3:[4, 6],
    4:[5],
    5:[6]
    },
    name = 'Flower'
    )
Flower.label_edges()
Flower.splits = False
Flower.F = [0, 2, 4, 9, 11]

Jet = NewFeynmanGraph({
    0:[1, 2, 5, 6],
    1:[8],
    2:[3],
    3:[4, 6, 7],
    4:[5, 8],
    5:[8],
    6:[7],
    7:[8]
    },
    name = 'Jet'
    )
Jet.label_edges()
Jet.splits = True

Rowboat = NewFeynmanGraph({
    0:[1, 2, 3, 6],
    1:[2, 8],
    2:[5],
    3:[4, 5],
    4:[5, 8],
    5:[6, 7],
    7:[8]
    },
    name = 'Rowboat'
    )
Rowboat.label_edges()
Rowboat.splits = True


# Not needed any more

Pinwheelito = NewFeynmanGraph({
    0:[1, 3, 4, 6],
    1:[2, 4],
    2:[3, 5],
    4:[7],
    5:[6, 7],
    6:[7]
    },
    name = 'Pinwheelito'
    )
Pinwheelito.label_edges()
Pinwheelito.splits = True
