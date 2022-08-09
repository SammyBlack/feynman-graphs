#include <iostream>
#include <stdlib.h>
#include <list>
#include <vector>
#include <fstream>
#include <ginac/ginac.h>

//using namespace std;
using std::string;
using std::vector;
using std::list;
using std::iostream;
using std::fstream;
using std::ofstream;
using std::ifstream;
using std::cout;
using std::endl;
using std::cerr;

#include "Kgraph.h"

GiNaC::matrix Kgraph::to_E_matrix(){
  int edgecount = 0;
  for (int i=0; i< v_list.size(); i++){
    edgecount += v_list[i].size();
  }
  edgecount /= 2;

  GiNaC::matrix E(v_list.size(), edgecount); 
  
  edgecount = 0;
  for (int i=0; i< v_list.size(); i++){
    for (list<int>::iterator j = v_list[i].begin(); j != v_list[i].end(); j++){
      if (*j > i){
	E(i, edgecount) = 1;
	E(*j, edgecount) = -1;
	edgecount ++;
      }
    }
  }
  return E;
}


bool Kgraph::has_double_edges(){
  for (int i=0; i<v_list.size(); i++){
    list<int> new_list = v_list[i];
    new_list.sort();
    new_list.unique();
    if (v_list[i].size() > new_list.size()){
      return true;
    }
  }
  return false;
}


unsigned long long int Kgraph::to_code(){
  unsigned long long int code = 0;

  for (int i=v_list.size()-1; i >= 1; i--){
    for (int j=i-1; j>=0; j--){
      //shift everything over
      code *= 2;
      //determine if graph[i] contains j
      for (list<int>::iterator k = v_list[i].begin(); k != v_list[i].end(); 
	   k++){
	if (*k == j){
	  //in which case put a 1 in code
	  code += 1;
	}
      }
    }
  }

  return code;
}


//add edge between v1 and v2, does not check for sanity of v1 and v2
void Kgraph::add_edge(int v1, int v2){
  v_list[v1].push_back(v2);
  v_list[v2].push_back(v1);
}

//add a new vertex to the end of the vertex list
void Kgraph::add_vertex(list<int> v){
  v_list.push_back(v);
}

//set the ith vertex
void Kgraph::set_vertex(list<int> V, int i){
  v_list[i] = V;
}

void Kgraph::clear(){
  v_list.clear();
}

list<Kgraph > read_graphs(char * filename){
  string line;
  list<Kgraph > ingraphs;

  ifstream graphfile (filename);
  if (graphfile.is_open()){
    while (! graphfile.eof() ){
      getline (graphfile, line);

      list<int> element;
      Kgraph G;
      for (int i = 0; i < line.size(); i++){
        if (line[i] == '{'){
          element.clear();
        }
        else if (line[i] == '}'){
          G.add_vertex(element);
        }
        else if (line[i] == ' '){
          ;//do nothing
        }
	else if (line[i] == '#'){
	  break;  // rest of line is a comment
	}
        else {//not robust, line[i] is an int
          element.push_back(atoi(&line[i]));
        }
      }
      ingraphs.push_back(G);
      G.clear();
    }
    graphfile.close();
  }
  return ingraphs;
}

list<Kgraph > francis_read_graphs(char * filename){
  string line;
  list<Kgraph > ingraphs;

  ifstream graphfile (filename);
  if (graphfile.is_open()){
    while (! graphfile.eof() ){
      getline (graphfile, line);
      
      if (line[0] == '['){
	//this is a good line
	int end1, end2;
	bool first=true;
	bool wrote_edge = false;
	Kgraph G(atoi(&line[1])); //not robust, maybe 2 digit numbers
	for (int i = 2; i < line.size(); i++){
	  if (line[i] == '['){
	    first = true;
	    wrote_edge = false;
	  }
	  else if (line[i] == ']'){
	    if (!wrote_edge){
	      G.add_edge(end1-1, end2-1);
	      wrote_edge = true;
	    }
	  }
	  else if ((line[i] == ' ') || (line[i] == ',')){
	    ;//do nothing
	  }
	  else if (line[i] == ';'){
	    //this graph is done
	    ingraphs.push_back(G);
	    G.clear();
	  }
	  else if (line[i] == '#'){
	    break;  // rest of line is a comment
	  }
	  else {//not robust, line[i] is an int
	    if (first){
	      end1 = atoi(&line[i]);
	      first = false;
	    }
	    else {
	      end2 = atoi(&line[i]);
	    }
	  }
	}
      }
    }
    graphfile.close();
  }
  return ingraphs;
}

//remove the edges adjacent to v 
void Kgraph::disconnect_vertex(int v){
  list<int> empty_vertex;
  v_list[v]= empty_vertex;

  list<int> new_vertex;
  for (int i=0; i<v_list.size(); i++){
    if (i != v){
      new_vertex.clear();
      for (list<int>::iterator j = v_list[i].begin();j != v_list[i].end(); j++){
        if (*j != v){
          new_vertex.push_back(*j);
        }
      }
      v_list[i] = new_vertex;
    }
  }

}

Kgraph::Kgraph(){
}

Kgraph::Kgraph(int n){
  v_list.resize(n);
}


//make a copy (without sharing any pointers)
Kgraph Kgraph::clone(){
  Kgraph new_graph(v_list.size());

  list<int> new_vertex;
  for (int i=0; i<v_list.size(); i++){
    new_vertex.clear();
    for (list<int>::iterator j = v_list[i].begin();j != v_list[i].end(); j++){
      new_vertex.push_back(*j);
    }
    new_graph.set_vertex(new_vertex, i);
  }
  
  return new_graph;
}

//convert graphs in my vector list int form to nauty form
void Kgraph::to_nauty(graph * n_graph, int m){
  set *gv;

  for (int i=0; i<v_list.size(); i++){
    gv = GRAPHROW(n_graph, i, m);
    EMPTYSET(gv, m);
    for (list<int>::iterator j = v_list[i].begin();
	 j != v_list[i].end(); j++){
      ADDELEMENT(gv, *j);
    }
  }

  return;
}

//check if two graphs in nauty form are equal
bool nauty_graph_equal(graph *n1, graph *n2, int n){
  if (MAXM != 1){
    cerr << "something funny in nauty_graph_equal" << endl;
  }
  for (int i=0; i<n; i++){
    if (n1[i] != n2[i]){
      return false;
    }
  }
  return true;
}

bool are_isomorphic_nauty(graph * n1, graph * n2, int n, int m){
  int lab1[MAXN], lab2[MAXN], ptn[MAXN], orbits[MAXN];
  static DEFAULTOPTIONS(options);
  //options.digraph = TRUE;
  statsblk(stats);
  setword workspace[50*MAXM];

  options.getcanon = TRUE;
  options.digraph = TRUE;

  graph n1canon[MAXN*MAXM];
  graph n2canon[MAXN*MAXM];

  //cout << *n1 << " " << *n2 << endl;

  nauty(n1, lab1, ptn, NULL, orbits, &options, &stats, workspace, 50*MAXM, 
	m, n, n1canon);

  nauty(n2, lab2, ptn, NULL, orbits, &options, &stats, workspace, 50*MAXM, 
	m, n, n2canon);

  if (nauty_graph_equal(n1canon,n2canon, n)){
    return true;
  }
  return false;
}

void Kgraph::francis_print(){
  cout << "[" << v_list.size();
  
  for (int i=0; i< v_list.size(); i++){
    for (list<int>::iterator j = v_list[i].begin(); j != v_list[i].end(); j++){
      if (*j > i){
	cout << ", [" << i+1 << ", " << *j + 1 << "]";
      }
    }
  }

  cout << "];" << endl;
}

void francis_print_graphs(list<Kgraph> graphs){
  for (list<Kgraph>::iterator i = graphs.begin(); 
       i!= graphs.end(); i++){
    (*i).francis_print();
  }
}

void Kgraph::ascii_print(){
  for (int j = 0; j < v_list.size(); j++){
    cout << "{ ";
    for (list<int>::iterator k = v_list[j].begin(); k != v_list[j].end(); k++){
      cout << *k << " ";
    }
    cout << "}";
    }
  cout << endl;
}

void Kgraph::ascii_print(ofstream &stream){
  for (int j = 0; j < v_list.size(); j++){
    stream << "{ ";
    for (list<int>::iterator k = v_list[j].begin(); k != v_list[j].end(); k++){
      stream << *k << " ";
    }
    stream << "}";
    }
  stream << endl;
}

//bool is whether or not to mark the 3-valent vertices as terminal
void Kgraph::lino_print(ofstream &stream, bool terminals){
  stream << "0 " << v_list.size() << endl;
  for (int j = 0; j < v_list.size(); j++){
    for (list<int>::iterator k = v_list[j].begin(); k != v_list[j].end(); k++){
      stream << *k+1 << " ";
    }
    if (terminals && v_list[j].size() == 3){
      stream << -1;
    } else {
      stream << 0;
    }
    stream << endl;
  }
}

void ascii_print_graphs(list<Kgraph> graphs){
  for (list<Kgraph>::iterator i = graphs.begin(); 
       i!= graphs.end(); i++){
    (*i).ascii_print();
  }
}

void ascii_print_graphs(list<Kgraph> graphs, ofstream &stream){
  for (list<Kgraph>::iterator i = graphs.begin(); 
       i!= graphs.end(); i++){
    (*i).ascii_print(stream);
  }
}

int Kgraph::size(){
  return v_list.size();
}

//want to identify the vertices of graph1 and graph2.  vertex_map is a 
//partial identification.  The free_edges are yet to be assigned.
bool are_isomorphic_helper(Kgraph graph1, 
			   Kgraph graph2, 
			   list<vector<int> > vertex_map, 
			   Kgraph free_edges1, 
			   Kgraph free_edges2){
  if (graph1.size() != graph2.size()){
    return false;
  }

  //base case, still needs checking
  if(vertex_map.size() == graph1.size()){
    for (list<vector<int> >::iterator i = vertex_map.begin(); 
	 i != vertex_map.end(); i++){
      
      list<int> v1 = graph1.get_vertex((*i)[0]);
      list<int> v2 = graph2.get_vertex((*i)[1]);

      //send v1 through the map
      list<int> newv1;
      for (list<int>::iterator j = v1.begin(); j != v1.end(); j++){
	for (list<vector<int> >::iterator m = vertex_map.begin(); 
	     m != vertex_map.end(); m++){
	  if (*j == (*m)[0]){
	    newv1.push_back((*m)[1]);
	  }
	}
      }

      newv1.sort();
      v2.sort();
      if (newv1 != v2){
	return false;
      }
    }
    return true;
  }

  //if there are unpaired vertices adjacent to currently identified 
  //vertices then pair those first
  for (list<vector<int> >::iterator i = vertex_map.begin(); 
       i != vertex_map.end(); i++){

    list<int> free_vert1 = free_edges1.get_vertex((*i)[0]);
    list<int> free_vert2 = free_edges2.get_vertex((*i)[1]);

    //shouldn't have different numbers of vertices yet to assign adjacent
    //to any already assigned vertex
    if (free_vert1.size() != free_vert2.size()){
      return false;
    }

    //there are vertices yet to be assigned adjacent to the current one
    if (free_vert1.size() > 0){
      bool found = false;
      //try each identification of the adjacent unassigned vertices
      for(list<int>::iterator j1 = free_vert1.begin(); j1 != free_vert1.end(); 
	  j1++){
	for(list<int>::iterator j2 = free_vert2.begin(); 
	    j2 != free_vert2.end(); j2++){
	  list<vector<int> > new_vertex_map(vertex_map);
	  vector<int> map_element(2);
	  map_element[0]=*j1;
	  map_element[1]=*j2;
	  new_vertex_map.push_back(map_element);
	  Kgraph new_free_edges1(free_edges1.size());
	  Kgraph new_free_edges2(free_edges2.size());

	  //make the new free_edges1 and free_edges2 matrices by removing all 
	  //references to j1 and j2 respectively
	  for (int k = 0; k < free_edges1.size(); k++){
	    list<int> oldv = free_edges1.get_vertex(k);
	    list<int> newv;
	    for (list<int>::iterator m = oldv.begin(); m!=oldv.end(); m++){
	      if (*m != *j1){
		newv.push_back(*m);
	      }
	    }
	    new_free_edges1.set_vertex(newv, k);
	  }

	  for (int k = 0; k < free_edges2.size(); k++){
	    list<int> oldv = free_edges2.get_vertex(k);
	    list<int> newv;
	    for (list<int>::iterator m = oldv.begin(); m!=oldv.end(); m++){
	      if (*m != *j2){
		newv.push_back(*m);
	      }
	    }
	    new_free_edges2.set_vertex(newv, k);
	  }

	  if (are_isomorphic_helper(graph1, graph2, new_vertex_map, 
				    new_free_edges1, new_free_edges2)){
	    found = true;
	  }
	}
      }
      return found;
    }
  }
  // if we've gotten here then there are never any free vertices adjacent
  // to known vertices, so make a fresh identification.  (

  //Should only happen on the first call
  if (vertex_map.size() != 0){
    cerr << "something funny in are_isomorphic_helper" << endl;
  }

  bool found = false;
  //try each identification
  for(int j1 = 0; j1 < graph1.size(); j1++){
    for(int j2 = 0; j2 < graph2.size(); j2++){
      list<vector<int> > new_vertex_map(vertex_map);
      vector<int> map_element(2);
      map_element[0]=j1;
      map_element[1]=j2;
      new_vertex_map.push_back(map_element);
      Kgraph new_free_edges1(graph1.size());
      Kgraph new_free_edges2(graph2.size());

      //make the new free_edges1 and free_edges2 matrices by removing all 
      //references to j1 and j2 respectively
      for (int k = 0; k < free_edges1.size(); k++){
	list<int> oldv = free_edges1.get_vertex(k);
	list<int> newv;
	for (list<int>::iterator m = oldv.begin(); m!=oldv.end(); m++){
	  if (*m != j1){
	    newv.push_back(*m);
	  }
	}
	new_free_edges1.set_vertex(newv, k);
      }
      
      for (int k = 0; k < free_edges2.size(); k++){
	list<int> oldv = free_edges2.get_vertex(k);
	list<int> newv;
	for (list<int>::iterator m = oldv.begin(); m!=oldv.end(); m++){
	  if (*m != j2){
	    newv.push_back(*m);
	  }
	}
	new_free_edges2.set_vertex(newv, k);
      }
      
      if (are_isomorphic_helper(graph1, graph2, new_vertex_map, 
				new_free_edges1, new_free_edges2)){
	found = true;
      }
    }
  }
  return found;
  
}


//is this isomorphic to graph2
bool Kgraph::is_isomorphic(Kgraph graph2){
  if (size() != graph2.size()){
    return false;
  }

  bool nauty;

  int n = size();
  int m = (n + WORDSIZE - 1) / WORDSIZE;
  nauty_check(WORDSIZE, m, n, NAUTYVERSIONID);
  
  graph n1[MAXN*MAXM];
  to_nauty(n1, m);
  graph n2[MAXN*MAXM];
  graph2.to_nauty(n2, m);

  nauty = are_isomorphic_nauty(n1, n2, n, m);

  if (!has_double_edges() && !graph2.has_double_edges()) {
    return nauty;
  }
  if (!nauty){
    //can't be isomorphic if even their skeletons are not
    return false;
  }
  //otherwise really do have to use the brute force isomorphism
  list<vector<int> > vertex_map;
  return are_isomorphic_helper(*this, graph2, vertex_map, *this, graph2); 

}

//determine if the graph is distinct from the graphs in graph_list
//return number of match (and -1 for distinct)
int Kgraph::is_distinct_num(list<Kgraph> graph_list){
  int count = 0;
  for (list<Kgraph>::iterator i = graph_list.begin(); 
       i != graph_list.end(); i++, count++){
    if (is_isomorphic(*i)){
      return count;
    }
  }
  return -1;
} 

//remove all edges joining v1 and v2
void Kgraph::remove_edge(int v1, int v2){
  if ((v1 >= v_list.size()) || (v2 >= v_list.size())){
    return;
  }

  v_list[v1].remove(v2);
  v_list[v2].remove(v1);
}

//remove n (or as many as there are if that is less) edges joining v1 and v2
void Kgraph::remove_edge(int v1, int v2, int n){
  if ((v1 >= v_list.size()) || (v2 >= v_list.size())){
    return;
  }

  list<int> L1, L2;

  int count = 0;
  for (list<int>::iterator it1 = v_list[v1].begin(); it1 != v_list[v1].end(); 
       it1++){
    if ((*it1 == v2) && (count < n)){
      count++;
    } else {
      L1.push_back(*it1);
    }
  }
  v_list[v1] = L1;

  count = 0;
  for (list<int>::iterator it2 = v_list[v2].begin(); it2 != v_list[v2].end(); 
       it2++){
    if ((*it2 == v1) && (count < n)){
      count++;
    } else {
      L2.push_back(*it2);
    }
  }
  v_list[v2] = L2;

}

//join the vertices v1 and v2
void Kgraph::merge_vertices(int v1, int v2){
  if ((v1 >= v_list.size()) || (v2 >= v_list.size())){
    return;
  }

  int vsmall = v1 < v2 ? v1 : v2;
  int vbig = v1 > v2 ? v1 : v2;
  
  list<int> new_vertex, old_vertex;
  for (int i=0; i<v_list.size(); i++){
    if (i != vbig){
      new_vertex.clear();
      if (i != vsmall){
	old_vertex = v_list[i];
      } else {
	old_vertex = v_list[vsmall];
	old_vertex.insert(old_vertex.end(), v_list[vbig].begin(), 
			  v_list[vbig].end()); 
      }
      for (list<int>::iterator j = old_vertex.begin();
	   j != old_vertex.end(); j++){
	if (*j < vbig){
	  new_vertex.push_back(*j);
	}
	else if (*j > vbig){
	  new_vertex.push_back(*j-1);
	}
	else{ //*j == vbig
	  new_vertex.push_back(vsmall);
	}
      }
      if (i<vbig){
	v_list[i] = new_vertex;
      }
      else if (i>vbig){
	v_list[i-1] = new_vertex;
      }
    }
  }
  v_list[v_list.size()-1].clear();
  v_list.resize(v_list.size()-1);
}

//remove the vertex v and all edges adjacent to it
void Kgraph::remove_vertex(int v){

  list<int> new_vertex;
  for (int i=0; i<v_list.size(); i++){
    if (i != v){
      new_vertex.clear();
      for (list<int>::iterator j = v_list[i].begin();j != v_list[i].end(); j++){
	if (*j < v){
	  new_vertex.push_back(*j);
	}
	else if (*j > v){
	  new_vertex.push_back(*j-1);
	}
      }
      if (i<v){
	v_list[i] = new_vertex;
      }
      else if (i>v){
	v_list[i-1] = new_vertex;
      }
    }
  }
  v_list[v_list.size()-1].clear();
  v_list.resize(v_list.size()-1);
}

bool Kgraph::is_connected(){
  list<int> component(v_list[0]);
  list<int> new_component_bits;
  int oldsize = component.size();

  bool changed = true;
  while(changed){
    changed = false;
    new_component_bits.clear();
    for (list<int>::iterator i = component.begin(); i!=component.end(); i++){
      new_component_bits.merge(v_list[*i]);
    }
    component.merge(new_component_bits);
    component.sort();
    component.unique();
    if (component.size() > oldsize){
      changed = true;
      oldsize = component.size();
    }
  }

  return (component.size() == v_list.size());
}


void Kgraph::remove_isolated_vertices(){
  
  for (int i=0; i<v_list.size(); i++){
    if (v_list[i].size() == 0){
      remove_vertex(i);
      i--;
    }
  }
}

//returns vertex i as a list of ints
//doesn't check sanity of i
list<int> Kgraph::get_vertex(int i){
  return v_list[i];
}

//take a list of completed graphs and return the uncompleted graphs
list<Kgraph> P_to_noP(list<Kgraph> graphs){
  list<Kgraph> result_list;
  Kgraph cur_graph;
  Kgraph spacer;

  for (list<Kgraph>::iterator i = graphs.begin(); i != graphs.end(); i++){
    for (int j=0; j<(*i).size(); j++){
      cur_graph = *i;
      cur_graph.remove_vertex(j);
      if (cur_graph.is_distinct_num(result_list) == -1){
        result_list.push_back(cur_graph);
      }
    }
    result_list.push_back(spacer);
  }
  return result_list;
}
