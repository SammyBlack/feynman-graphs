#include <iostream>
#include <ginac/ginac.h>
#include <time.h>

using std::cout;
using std::endl;
using std::cerr;
using std::string;
using std::vector;
using std::list;
using std::pair;
using std::ofstream;
using namespace GiNaC;

#include "Kgraph.h"

//graph with include and exclude lists
struct graph_ix {
  Kgraph graph;
  list<pair<int, int> > incl;
  list<pair<int, int> > excl;
};

bool vec_has(vector<int> V, int n){
  for (vector<int>::iterator i=V.begin(); i!=V.end(); i++){
    if (n==*i){
      return true;
    }
  }
  return false;
}

bool list_has(list<int> V, int n){
  for (list<int>::iterator i=V.begin(); i!=V.end(); i++){
    if (n==*i){
      return true;
    }
  }
  return false;
}

//print in the format for sammy's sage program
void sammy_print(graph_ix G, string graphname){
  cout << graphname << " = NewFeynmanGraph({" << endl;
  for (int i=0; i<(G.graph).size()-1; i++){
    list<int> v = (G.graph).get_vertex(i);
    list<int> partv;
    for (list<int>::iterator j = v.begin(); j != v.end(); j++){
      if ((*j) >= i){
	partv.push_back(*j);
      }
    }
    if (partv.size() > 0){
      cout << "\t" << i << ":[";
      bool first = true;
      for (list<int>::iterator j = partv.begin(); j != partv.end(); j++){
	if (first){
	  first = false;
	}
	else{
	  cout << ", ";
	}
	cout << *j;
      }
      cout << "]";
      if (i < (G.graph).size()-2){
	cout << ",";
      }
    cout << endl;
    }
  }
  cout << "\t}," << endl << "\tname = '" << graphname << "'" << endl << "\t)"
       << endl;
  cout << graphname << ".incl_verts = [";
  bool first = true;
  for (list<pair<int, int> >::iterator i = (G.incl).begin(); 
       i != (G.incl).end(); i++){
    if (first){
      first = false;
    }
    else {
      cout << ", ";
    }
    cout << "(" << (*i).first << ", " << (*i).second << ")";
  }
  cout << "]" << endl;
  cout << graphname << ".excl_verts = [";
  first = true;
  for (list<pair<int, int> >::iterator i = (G.excl).begin(); 
       i != (G.excl).end(); i++){
    if (first){
      first = false;
    }
    else {
      cout << ", ";
    }
    cout << "(" << (*i).first << ", " << (*i).second << ")";
  }
  cout << "]" << endl;
  cout <<  graphname << "." << "label_edges()" << endl;
}


void sammy_print_graphs(list<graph_ix> Glist, string basename){
  int j=0;
  for (list<graph_ix>::iterator i = Glist.begin(); i != Glist.end(); i++){
    string graphname = basename;
    char numstr [10];
    sprintf(numstr, "%d", j); 
    graphname += numstr;
    sammy_print(*i, graphname);
    j++;
  }

  cout << basename << "_list = [";
  j = 0;
  for (list<graph_ix>::iterator i = Glist.begin(); i != Glist.end(); i++){
    if (i!= Glist.begin()){
      cout << ", ";
    }
    string graphname = basename;
    char numstr [10];
    sprintf(numstr, "%d", j); 
    graphname += numstr;
    cout << graphname;
    j++;
  }
  cout << "]" << endl;
}


//widget the edge in all possible ways
//does not check if that edge is there.
//only returns one possibility for double protection
list<graph_ix> all_widgetify_edge(graph_ix G, int v1, int v2){
  list<graph_ix> result;
  list<int> empty;

  graph_ix newG;
  newG.graph = (G.graph).clone();
  newG.incl = G.incl;
  newG.excl = G.excl;

  (newG.graph).add_edge(v1, v2);
  (newG.incl).push_back(std::make_pair(v1, v2));
  (newG.excl).push_back(std::make_pair(v1, v2));
  result.push_back(newG);

  newG.graph = (G.graph).clone();
  newG.incl = G.incl;
  newG.excl = G.excl;
  (newG.graph).remove_edge(v1, v2, 1);
  (newG.graph).add_vertex(empty);
  (newG.graph).add_edge(v1, (newG.graph).size()-1);
  (newG.graph).add_edge(v2, (newG.graph).size()-1);
  (newG.incl).push_back(std::make_pair(v1, (newG.graph).size()-1));
  (newG.excl).push_back(std::make_pair(v2, (newG.graph).size()-1));
  result.push_back(newG);

  graph_ix anotherG;
  anotherG.graph = (newG.graph).clone();
  anotherG.incl = newG.incl;
  anotherG.excl = newG.excl;
  (anotherG.graph).add_edge(v1, v2);
  (anotherG.excl).push_back(std::make_pair(v1, v2));
  result.push_back(anotherG);

  return result;
}

//double widget the edge (other things left over from a past version)
//does not check if that edge is there.
//only returns one possibility for double protection
list<graph_ix> widgetify_edge(graph_ix G, int v1, int v2){
  list<graph_ix> result;
  list<int> empty;

  graph_ix newG;
  newG.graph = (G.graph).clone();
  newG.incl = G.incl;
  newG.excl = G.excl;

  //newG.add_edge(v1, v2);
  //result.push_back(newG);

  //newG = G.clone();
  //newG.remove_edge(v1, v2, 1);
  (newG.graph).add_vertex(empty);
  (newG.graph).add_edge(v1, (newG.graph).size()-1);
  (newG.graph).add_edge(v2, (newG.graph).size()-1);
  (newG.incl).push_back(std::make_pair(v1, (newG.graph).size()-1));
  (newG.excl).push_back(std::make_pair(v1, v2));
  (newG.excl).push_back(std::make_pair(v2, (newG.graph).size()-1));
  //result.push_back(newG);

  //newG.add_edge(v1, v2);
  result.push_back(newG);

  return result;
}

graph_ix remove_isolated_vertices_graph_ix(graph_ix G){
  graph_ix newG;
  newG.graph = (G.graph).clone();
  newG.incl = G.incl;
  newG.excl = G.excl;

  for (int i=(newG.graph).size()-1; i>=0; i--){
    list<int> v = (newG.graph).get_vertex(i);
    if (v.size() == 0){
      (newG.graph).remove_vertex(i);

      list<pair<int, int> > temp = newG.incl;
      list<pair<int, int> > empty;
      newG.incl = empty;
      pair<int, int> cur_elt;
      for (list<pair<int, int> >::iterator elt = temp.begin(); 
	   elt != temp.end(); elt++){
	if ((*elt).first > i){
	  cur_elt.first = (*elt).first-1;
	} else {
	  cur_elt.first = (*elt).first;
	}
	if ((*elt).second > i){
	  cur_elt.second = (*elt).second-1;
	} else {
	  cur_elt.second = (*elt).second;
	} 
	(newG.incl).push_back(cur_elt);
      }
      temp = newG.excl;
      newG.excl = empty;
      for (list<pair<int, int> >::iterator elt = temp.begin(); 
	   elt != temp.end(); elt++){
	if ((*elt).first > i){
	  cur_elt.first = (*elt).first-1;
	} else {
	  cur_elt.first = (*elt).first;
	}
	if ((*elt).second > i){
	  cur_elt.second = (*elt).second-1;
	} else {
	  cur_elt.second = (*elt).second;
	} 
	(newG.excl).push_back(cur_elt);
      }      
    }
  }
  //if ((newG.incl).size() > 5) {
  //  cout << "**********" << endl;
  //  sammy_print(newG, "newG");
  //  sammy_print(G, "G");
  //}
  return newG;
}


//return the edges of G as a list of pairs of vertices
list<pair<int, int> > get_edgelist(Kgraph G){
  list<pair<int, int> > result;

  for (int i=0; i<G.size(); i++){
    list<int> vlist = G.get_vertex(i);
    for (list<int>::iterator j=vlist.begin(); j!=vlist.end(); j++){
      if ((*j) >= i){
	result.push_back(std::make_pair(i,*j));
      }
    }
  }
  return result;
}


bool is_distinct(list<graph_ix> L, graph_ix G){
  list<Kgraph> Lgraph;
  for (list<graph_ix>::iterator i = L.begin(); i!= L.end(); i++){
    Lgraph.push_back((*i).graph);
  }
  if ((G.graph).is_distinct_num(Lgraph) == -1){
    return true;
  }
  return false;
}

list<graph_ix> partial_widget_from_double(graph_ix G){
  //make excluded edges into a list of pairs (corresponding to the same
  //widget but not robust, just assume they're in order)

  list<pair<pair<int, int>, pair<int, int> > > extra_edges;
  bool even = true;
  pair<pair<int, int>, pair<int, int> > cur_pair;
  for (list<pair<int, int> >::iterator i = (G.excl).begin(); 
       i!= (G.excl).end(); i++){
    if (even){
      cur_pair.first = *i;
      even = false;
    }
    else {
      cur_pair.second = *i;
      extra_edges.push_back(cur_pair);
      even = true;
    }
  }

  list<graph_ix> result;
  result.push_back(G);
  for (list<pair<pair<int, int>, pair<int, int> > >::iterator i 
	 = extra_edges.begin(); i != extra_edges.end(); i++){
    list<graph_ix> newresult = result;
    for (list<graph_ix>::iterator curG = result.begin(); 
	 curG != result.end(); curG++){
      //make the two smaller widgets  again not robust, just assume 
      // they are in the expected order
      graph_ix newG;
      newG.graph = ((*curG).graph).clone();
      (newG.graph).remove_edge(((*i).first).first, ((*i).first).second, 1);
      newG.incl = (*curG).incl;
      newG.excl = (*curG).excl;
      (newG.excl).remove((*i).first);
      newresult.push_back(newG);
      
      //cout << "first way to unwidget" << endl;
      //sammy_print(newG, "test");


      newG.graph = ((*curG).graph).clone();
      int v1 = ((*i).second).first;
      int v2 = ((*i).second).second;
      int v3 = ((*i).first).first;  //incl is (v3,v2) excl is (v3,v1) (v1,v2)
      (newG.graph).remove_edge(v1, v2);
      (newG.graph).remove_edge(v3, v2);
      (newG.graph).add_edge(v3, v1);
      newG.incl = (*curG).incl;
      newG.excl = (*curG).excl;
      (newG.incl).remove(std::make_pair(v3, v2));
      (newG.incl).push_back((*i).first);
      (newG.excl).remove((*i).second);
      //if ((newG.incl).size() > 5) {
      //	cout << "**********" << endl;
      //	sammy_print(newG, "newG");
      //	sammy_print(*curG, "curG");
      //}
      /*
      list<pair<int, int> > temp = (*curG).incl;
      list<pair<int, int> > empty;
      pair<int, int> cur_elt;
      temp.remove(std::make_pair(((*i).first).first, 
					((*i).second).second));
      temp.push_back((*i).first);
      newG.incl = empty;
      for (list<pair<int, int> >::iterator elt = temp.begin(); 
	   elt != temp.end(); elt++){
	if ((*elt).first > v2){
	  cur_elt.first = (*elt).first-1;
	} else {
	  cur_elt.first = (*elt).first;
	}
	if ((*elt).second > v2){
	  cur_elt.second = (*elt).second-1;
	} else {
	  cur_elt.second = (*elt).second;
	} 
	(newG.incl).push_back(cur_elt);
      }

      temp = (*curG).excl;
      temp.remove((*i).second);
      newG.excl = empty;
      for (list<pair<int, int> >::iterator elt = temp.begin(); 
	   elt != temp.end(); elt++){
	if ((*elt).first > v2){
	  cur_elt.first = (*elt).first-1;
	} else {
	  cur_elt.first = (*elt).first;
	}
	if ((*elt).second > v2){
	  cur_elt.second = (*elt).second-1;
	} else {
	  cur_elt.second = (*elt).second;
	} 
	(newG.excl).push_back(cur_elt);
      }
      */
      //cout << (newG.incl).size();
      newresult.push_back(newG);//remove_isolated_vertices_graph_ix(newG));
      //cout << "second way to unwidget" << endl;
      //sammy_print(newG, "test");
    }
    result=newresult;
  }
  
  list<graph_ix> shifted_result;
  for (list<graph_ix>::iterator i = result.begin(); i!= result.end(); i++){
    graph_ix shifted_graph = remove_isolated_vertices_graph_ix(*i);
    //if (is_distinct(shifted_result, shifted_graph)){
      shifted_result.push_back(shifted_graph);
      //  }
  }
  return shifted_result;
}


//widgitify from 0 to 5 edges of the graph and return the result 
//without isomorphic copies
list<graph_ix> widgetify(graph_ix G){
  list<graph_ix> result;
  list<pair<int, int> > elist = get_edgelist(G.graph);

  //first no widgets
  result.push_back(G);
  //loop for 1 widget
  for (list<pair<int, int> >::iterator i = elist.begin(); 
       i != elist.end(); i++){
    //cout << "edgei: " << (*i).first << " " << (*i).second << endl;
    list<graph_ix> i_graphs = widgetify_edge(G, (*i).first, (*i).second);
    for (list<graph_ix>::iterator i_graph = i_graphs.begin();
	 i_graph != i_graphs.end(); i_graph++){
      //cout << "i_graph loop" << endl;
      if (is_distinct(result, *i_graph)){
	//one widget
	result.push_back(*i_graph);
	//(*i_graph).ascii_print();
	//cout << "put a graph in with 1 widget" << endl;
	//loop for 2 widgets
	list<pair<int, int> >::iterator j = i;
	j++;
	for (; j != elist.end(); j++){
	  //cout << "edgej: " << (*j).first << " " << (*j).second << endl;
	  //cout << "j loop" << endl;
	  list<graph_ix> j_graphs = widgetify_edge(*i_graph, 
						  (*j).first, (*j).second);
	  for (list<graph_ix>::iterator j_graph = j_graphs.begin();
	       j_graph != j_graphs.end(); j_graph++){
	    //cout << "j_graph loop" << endl;
	    if (is_distinct(result, *j_graph)){
	      //two widgets
	      result.push_back(*j_graph);
	      //(*j_graph).ascii_print();
	      //cout << "put a graph in with 2 widgets" << endl;
	      //loop for 3 widgets
	      list<pair<int, int> >::iterator k = j;
	      k++;
	      for (; k != elist.end(); k++){
		list<graph_ix> k_graphs = widgetify_edge(*j_graph, (*k).first, 
							 (*k).second);
		//cout << "k loop" << endl;
		for (list<graph_ix>::iterator k_graph = k_graphs.begin();
		     k_graph != k_graphs.end(); k_graph++){
		  //cout << "k_graph loop" << endl;
		  if (is_distinct(result, *k_graph)){
		    //three widgets
		    result.push_back(*k_graph);
		    //cout << "put a graph in with 3 widgets" << endl;
		    //loop for 4 widgets
		    list<pair<int, int> >::iterator l = k;
		    l++;
		    for (; l != elist.end(); l++){
		      list<graph_ix> l_graphs = widgetify_edge(*k_graph, 
							      (*l).first, 
							      (*l).second);
		      //cout << "l loop" << endl;
		      for (list<graph_ix>::iterator l_graph = l_graphs.begin();
			   l_graph != l_graphs.end(); l_graph++){
			//cout << "l_graph loop" << endl;
			if (is_distinct(result, *l_graph)){
			  //four widgets
			  result.push_back(*l_graph);
			  //cout << "put a graph in with 4 widgets" << endl;
			  //loop for 5 widgets
			  list<pair<int, int> >::iterator m = l;
			  m++;
			  for (; m != elist.end(); m++){
			    list<graph_ix> m_graphs = 
			      widgetify_edge(*l_graph, (*m).first, (*m).second);
			    //cout << "m loop" << endl;
			    for (list<graph_ix>::iterator m_graph 
				   = m_graphs.begin();
				 m_graph != m_graphs.end(); m_graph++){
			      //cout << "m_graph loop" << endl;
			      if (is_distinct(result, *m_graph)){
				//five widgets
				result.push_back(*m_graph);
				//cout << "put a graph in with 5 widgets" << endl;
			      }
			    }
			  }
			}
		      }
		    }
		  }
		}
	      }
	    }
	  }
	}
      }
    }
  }
  return result;
}


int main(int argc, char ** argv){
  list<pair<int, int> > empty;

  //****************  K4 ******************
  
  Kgraph K4(4);
  K4.add_edge(0,1);
  K4.add_edge(0,2);
  K4.add_edge(0,3);
  K4.add_edge(1,2);
  K4.add_edge(1,3);
  K4.add_edge(2,3);

  graph_ix K4ix;
  K4ix.graph = K4;
  K4ix.incl = empty;
  K4ix.excl = empty;
  /*
  list<graph_ix> K4widgeted = widgetify(K4ix);

  //sammy_print_graphs(K4widgeted, "K4w");
  
  int i=0;
  for (list<graph_ix>::iterator j=K4widgeted.begin(); 
       j != K4widgeted.end(); j++){
    if (i==5){
      char namestr [10];
      sprintf(namestr, "K4n%dw", i); 
      sammy_print_graphs(partial_widget_from_double(*j), namestr);
    }
    i++;
  }
  cout << "list_of_listnames = [K4n5w_list]" << endl; 
  */
  //**************** wheel with 4 spokes ***********

  Kgraph W4(5);
  W4.add_edge(0,1);
  W4.add_edge(0,2);
  W4.add_edge(0,3);
  W4.add_edge(0,4);
  W4.add_edge(1,2);
  W4.add_edge(2,3);
  W4.add_edge(3,4);
  W4.add_edge(1,4);

  graph_ix W4ix;
  W4ix.graph = W4;
  W4ix.incl = empty;
  W4ix.excl = empty;
  /*
  list<graph_ix> W4widgeted = widgetify(W4ix);

  //sammy_print_graphs(W4widgeted, "W4w");
  
  int nonsplit_array[] = {5,7,8,9,11,14,15,19,25,31};
  list<int> nonsplit (nonsplit_array, 
  		      nonsplit_array + sizeof(nonsplit_array) / sizeof(int) );
  
  int i=0;
  for (list<graph_ix>::iterator j=W4widgeted.begin(); 
       j != W4widgeted.end(); j++){
    if (list_has(nonsplit, i)){
      char namestr [10];
      sprintf(namestr, "W4n%dw", i); 
      sammy_print_graphs(partial_widget_from_double(*j), namestr);
    }
    i++;
  }
  cout << "list_of_listnames = [";
  bool first = true;
  for (list<int>::iterator i = nonsplit.begin(); i!=nonsplit.end(); i++){
    if (first){
      first = false;
    } else {
      cout << ", ";
    }
    cout << "W4n" << *i << "w_list";
  }
  cout << "]" << endl;
  */
  //****************** K5 minus an edge **************

  Kgraph K5m = W4.clone();
  K5m.add_edge(1,3);
  
  graph_ix K5mix;
  K5mix.graph = K5m;
  K5mix.incl = empty;
  K5mix.excl = empty;
  /*
  list<graph_ix> K5mwidgeted = widgetify(K5mix);

  //sammy_print_graphs(K5mwidgeted, "K5mw");

  int nonsplit_array[] = {5,6,7,8,9,10,11,13,14,15,18,19,20,22,24,26,27,28,31,33,36,39,41,46,47,50};
  list<int> nonsplit (nonsplit_array, 
  		      nonsplit_array + sizeof(nonsplit_array) / sizeof(int) );

  int i=0;
  for (list<graph_ix>::iterator j=K5mwidgeted.begin(); 
       j != K5mwidgeted.end(); j++){
    if (list_has(nonsplit, i)){
      char namestr [10];
      sprintf(namestr, "K5mn%dw", i); 
      sammy_print_graphs(partial_widget_from_double(*j), namestr);
    }
    i++;
  }
  cout << "list_of_listnames = [";
  bool first = true;
  for (list<int>::iterator i = nonsplit.begin(); i!=nonsplit.end(); i++){
    if (first){
      first = false;
    } else {
      cout << ", ";
    }
    cout << "K5mn" << *i << "w_list";
  }
  cout << "]" << endl;
  */
  //*************triangular prism***************

  Kgraph P(6);
  P.add_edge(0,1);
  P.add_edge(0,2);
  P.add_edge(1,2);
  P.add_edge(3,4);
  P.add_edge(3,5);
  P.add_edge(4,5);
  P.add_edge(0,3);
  P.add_edge(1,4);
  P.add_edge(2,5);

  graph_ix Pix;
  Pix.graph = P;
  Pix.incl = empty;
  Pix.excl = empty;
  /*
  list<graph_ix> Pwidgeted = widgetify(Pix);

  //sammy_print_graphs(Pwidgeted, "Pw");

  int nonsplit_array[] = {4,5,6,7,8,9,10,11,12,13,14,16,17,18,19,20,21,22,24,25,26,27,29,30,31,32,36,41,42,43,44,46,47,49,52,53,59,64};
  list<int> nonsplit (nonsplit_array, 
  		      nonsplit_array + sizeof(nonsplit_array) / sizeof(int) );

  int i=0;
  for (list<graph_ix>::iterator j=Pwidgeted.begin(); 
       j != Pwidgeted.end(); j++){
    if (list_has(nonsplit, i)){
      char namestr [10];
      sprintf(namestr, "Pn%dw", i); 
      sammy_print_graphs(partial_widget_from_double(*j), namestr);
    }
    i++;
  }
  cout << "list_of_listnames = [";
  bool first = true;
  for (list<int>::iterator i = nonsplit.begin(); i!=nonsplit.end(); i++){
    if (first){
      first = false;
    } else {
      cout << ", ";
    }
    cout << "Pn" << *i << "w_list";
  }
  cout << "]" << endl;  
  */
  //*************** TU**************

  Kgraph TU = P.clone();
  TU.add_edge(0, 4);

  graph_ix TUix;
  TUix.graph = TU;
  TUix.incl = empty;
  TUix.excl = empty;

  
  list<graph_ix> TUwidgeted = widgetify(TUix);

  //sammy_print_graphs(TUwidgeted, "TUw");

  int nonsplit_array[] = {5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 27, 28, 30, 31, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 82, 83, 84, 86, 90, 98, 99, 100, 101, 102, 104, 105, 106, 107, 109, 110, 111, 113, 114, 116, 119, 120, 121, 122, 123, 124, 125, 126, 127, 129, 130, 132, 133, 135, 136, 137, 138, 140, 141, 143, 144, 145, 146, 147, 148, 149, 150, 151, 153, 154, 156, 157, 160, 161, 162, 163, 164, 165, 166, 167, 168, 170, 171, 172, 173, 174, 176, 177, 178, 179, 180, 181, 182, 185, 186, 188, 195, 196, 197, 198, 199, 200, 201, 202, 204, 205, 206, 208, 212, 219, 225, 227, 237, 238, 239, 240, 241, 243, 244, 245, 246, 248, 249, 250, 251, 252, 253, 255, 256, 257, 258, 259, 260, 261, 262, 263, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 277, 280, 281, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 297, 298, 299, 300, 301, 302, 305, 307, 308, 310, 311, 312, 313, 314, 315, 316, 319, 324, 327, 328, 338, 339, 340, 341, 343, 344, 345, 346, 347, 350, 351, 352, 354, 355, 359, 360, 361, 362, 364, 367, 370, 378, 379};
  list<int> nonsplit (nonsplit_array, 
  		      nonsplit_array + sizeof(nonsplit_array) / sizeof(int) );

  int i=0;
  for (list<graph_ix>::iterator j=TUwidgeted.begin(); 
       j != TUwidgeted.end(); j++){
    if (list_has(nonsplit, i)){
      char namestr [10];
      sprintf(namestr, "TUn%dw", i); 
      sammy_print_graphs(partial_widget_from_double(*j), namestr);
    }
    i++;
  }
  cout << "list_of_listnames = [";
  bool first = true;
  for (list<int>::iterator i = nonsplit.begin(); i!=nonsplit.end(); i++){
    if (first){
      first = false;
    } else {
      cout << ", ";
    }
    cout << "TUn" << *i << "w_list";
  }
  cout << "]" << endl;  
  
  //*************wheel with 5 spokes ***************

  
  /*
  Kgraph W5(6);
  W5.add_edge(0,1);
  W5.add_edge(0,2);
  W5.add_edge(0,3);
  W5.add_edge(0,4);
  W5.add_edge(0,5);
  W5.add_edge(1,2);
  W5.add_edge(2,3);
  W5.add_edge(3,4);
  W5.add_edge(4,5);
  W5.add_edge(5,1);

  graph_ix W5ix;
  W5ix.graph = W5;
  W5ix.incl = empty;
  W5ix.excl = empty;

  list<graph_ix> W5widgeted = widgetify(W5ix);

  sammy_print_graphs(W5widgeted, "W5w");
  */

  //**************** D ********************

  /*
  Kgraph D(6);
  D.add_edge(0,1);
  D.add_edge(0,2);
  D.add_edge(0,3);
  D.add_edge(0,4);
  D.add_edge(5,1);
  D.add_edge(5,2);
  D.add_edge(5,3);
  D.add_edge(5,4);
  D.add_edge(1,2);
  D.add_edge(2,3);
  D.add_edge(3,4);

  graph_ix Dix;
  Dix.graph = D;
  Dix.incl = empty;
  Dix.excl = empty;

  list<graph_ix> Dwidgeted = widgetify(Dix);

  sammy_print_graphs(Dwidgeted, "Dw");
  */

  //**************** hexahedral graph 4********

  
  Kgraph H4 = TU.clone();
  H4.add_edge(0,5);

  graph_ix H4ix;
  H4ix.graph = H4;
  H4ix.incl = empty;
  H4ix.excl = empty;

  /*
  list<graph_ix> H4widgeted = widgetify(H4ix);

  sammy_print_graphs(H4widgeted, "H4w");
  */
}


