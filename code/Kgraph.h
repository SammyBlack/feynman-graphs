#include <list>
#include <vector>
#define MAXN 10
#include "/home/karen/common/nauty25/nauty.h"
#include <ginac/ginac.h>

using std::vector;
using std::list;
using std::ofstream;


class Kgraph{
  vector<list<int> > v_list;

 public:
  //constructors
  Kgraph();
  Kgraph(int);

  //output and conversion routines
  unsigned long long int to_code();
  void to_nauty(graph *, int);
  void francis_print();
  void lino_print(ofstream &stream, bool terminals);
  void ascii_print();
  void ascii_print(ofstream &stream);
  list<int> get_vertex(int);
  GiNaC::matrix to_E_matrix();

  //modification routines
  void add_edge(int, int);
  void add_vertex(list<int>);
  void set_vertex(list<int>, int);
  void disconnect_vertex(int);
  void remove_edge(int, int);
  void remove_edge(int, int, int);
  void merge_vertices(int, int);
  void remove_vertex(int);
  void remove_isolated_vertices();

  //global structure routines
  void clear();
  Kgraph clone();

  //properties
  int size();
  bool is_isomorphic(Kgraph);
  int is_distinct_num(list<Kgraph> graph_list);
  bool is_connected();
  bool has_double_edges();
};



//routines for lists of graphs
list<Kgraph> francis_read_graphs(char * filename);
list<Kgraph> read_graphs(char * filename);
void francis_print_graphs(list<Kgraph> graphs);
void ascii_print_graphs(list<Kgraph> graphs);
void ascii_print_graphs(list<Kgraph> graphs, ofstream &stream);
list<Kgraph> P_to_noP(list<Kgraph> graphs);


