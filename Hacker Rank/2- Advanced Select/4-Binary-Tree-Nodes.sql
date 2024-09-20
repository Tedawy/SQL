-- You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree,
-- and P is the parent of N
-- Write a query to find the node type of Binary Tree ordered by the value of the node. 
-- Output one of the following for each node:
--      Root: If node is root node.
--      Leaf: If node is leaf node.
--      Inner: If node is neither root nor leaf node.


Select n,
    case 
        when p is null then 'Root'
        when n not in (select p from bst where p is not null) then 'Leaf'
        else 'Inner'
        end as node_type 
from 
    bst
order by 
    n;

/*
You are given a table BST containing nodes (N) and their parent nodes (P). 
You need to figure out if each node is a Root, Leaf, or Inner node and display that information.

	•	A Root node has no parent (P IS NULL).
	•	A Leaf node has no children (it does not appear as a parent P for any other node).
	•	An Inner node is neither a root nor a leaf (it has both a parent and children).

Solution Breakdown:

	1.	Root: If the parent P is NULL, the node is a root.
	2.	Leaf: If the node N doesn’t appear as a parent (P) in the table, it’s a leaf.
	3.	Inner: If the node has both a parent and children, it’s an inner node.

The query uses a CASE statement to check these conditions and outputs the node type accordingly.
*/