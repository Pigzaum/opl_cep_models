/*********************************************
 * OPL 12.7.1.0 Model
 * Author: Guilherme Chagas
 * Creation Date: 29/08/2017 at 16:46:43
 *********************************************/

// parameters --------------------------------------------------------

int n = ...; // number of vertices

range vertices = 1..n;

int a[vertices][vertices] = ...; // adjacencies matrix 

// positive edges set
{int} pos_edges[i in vertices] = {j | j in vertices : a[i][j] == 1};
// negative edges set
{int} neg_edges[i in vertices] = {j | j in vertices : a[i][j] == 0};

// variables ---------------------------------------------------------

dvar boolean x[vertices][vertices];

// model -------------------------------------------------------------

minimize sum (i in vertices, j in pos_edges[i] : j > i) x[i][j] + 
	sum (i in vertices, j in neg_edges[i] : j > i) (1 - x[i][j]);

subject to 
{
	// first constraint
	forall(i in vertices)
	  forall(j in vertices : j > i)
	    forall(k in vertices : k > j)
      	{
	      	cons1:
	      	{
	      		x[i][k] <= x[i][j] + x[j][k];
	      		x[i][j] <= x[i][k] + x[j][k];
	      		x[j][k] <= x[i][j] + x[i][k];
      	  	}	      	
      	}
}