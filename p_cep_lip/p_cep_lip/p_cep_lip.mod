/*********************************************
 * OPL 12.8.0.0 Model
 * Author: guilherme
 * Creation Date: 23/03/2018 at 22:05:36
 * Bulhoes et al. (2017) linear inter program
 *********************************************/

// parameters --------------------------------------------------------

int n = ...; // number of vertices
int p = ...; // number of clusters

range vertices = 1..n;

int a[vertices][vertices] = ...; // adjacencies matrix 

// variables ---------------------------------------------------------

dvar boolean x[vertices][vertices];
dvar boolean y[vertices];

// model -------------------------------------------------------------

minimize sum(i in vertices, j in vertices : i < j && a[i][j] == 1) 
	(1 - x[i][j]) + sum(i in vertices, j in vertices : i < j && 
	a[i][j] == 0) x[i][j];
	
subject to
{
	// first constraint
	forall(i in vertices)
  		forall(j in vertices: i < j)
			forall(k in vertices: j < k)
	      	{
	      		cons1:
	      		{
	      			-x[i][j] + x[i][k] + x[j][k] + y[k] <= 1;
		 	      	x[i][j] - x[i][k] + x[j][k] <= 1;
		 	      	x[i][j] - x[i][k] - x[j][k] <= 1;
         		}		 	      	
	      	}
  	
  	// second constraint
  	cons2:
  	y[1] == 1;
  	
  	// third constraint
  	forall(i in vertices)
  		forall(j in vertices: i < j && j >= 2)
		{	
			cons3:
	  		y[j] <= 1 - x[i][j]; 		  		
  		}
  		
	// fourth constraint
	forall(j in vertices: j >= 2)
  	{
  		cons4:  	
  		y[j] >= 1 - sum(i in vertices: i < j) x[i][j];
  	}
  	
  	// fifth constraint
  	sum(j in vertices) y[j] == p;
}