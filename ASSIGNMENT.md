Assignment - In progress
Add attachment(s), then choose the appropriate button at the bottom.
Title    Randomized Optimization, Unsupervised Learning, and Dimensionality Reduction
Due      Mar 30, 2014 11:55 pm
Status   Not Started
Grade Scale      Points (max 100.0)
Instructions
Numbers

The assignment is worth 20% of your final grade.

It is divided into two major parts, reflecting the two major topics of this part of the course. It might help your planning if you think of it as two assignments that have been put together. Divide your time appropriately.

Part the First

Why?

The purpose of this part of the project is to explore random search. As always, it is important to realize that understanding an algorithm or technique requires more than reading about that algorithm or even implementing it. One should actually have experience seeing how it behaves under a variety of circumstances.

As such, you will be asked to implement or steal several randomized search algorithms. In addition, you will be asked to exercise your creativity in coming up with problems that exercise the strengths of each.

As always, you may program in any language that you wish (we do prefer java, matlab, Lisp or C++; let us know beforehand if youre going to use something else). In any case it is your responsibility to make sure that the code runs on the standard CoC linux boxes. Re-read that last sentence.

Read everything below carefully!

 

The Problems Given to You

You must implement four local random search algorithms. They are:

randomized hill climbing
simulated annealing
a genetic algorithm
MIMIC
You will then use the first three algorithms to find good weights for a neural network. In particular, you will use them instead of backprop for the neural network you used in assignment #1 on at least one of the problems you created for assignment #1. Notice that weights in a neural network are continuous and real-valued instead of discrete so you might want to think a little bit about what it means to apply these sorts of algorithms in such a domain.

The Problems You Give Us

In addition to finding weights for a neural network, you must create three optimization problem domains on your own. For the purpose of this assignment an "optimization problem" is just a fitness function one is trying to maximize (as opposed to a cost function one is trying to minimize). This doesnt make things easier or harder, but picking one over the other makes things easier for us to grade.

Please note that the problems you create should be over discrete-valued parameter spaces. Bit strings are preferable.

The first problem should highlight advantages of your genetic algorithm, the second of simulated annealing, and the third of MIMIC. Be creative and thoughtful. It is not required that the problems be complicated or painful. They can be simple. For example, the 4-peaks and k-color problems are rather straightforward, but illustrate relative strengths rather neatly.

 
Part the Second

Why?

Now its time to explore unsupervised learning algorithms. This part of the assignment asks you to use some of the clustering and dimensionality reduction algorithms weve looked at in class and to revisit earlier assignments. The goal is for you to think about how these algorithms are the same as, different from, and interact with your earlier work.

The same ground rules apply for programming languages.

Read everything below carefully!

 
The Problems Given to You

You are to implement (or find the code for) six algorithms. The first two are clustering algorithms:

k-means clustering
Expectation Maximization
You can choose your own measures of distance/similarity. Naturally, youll have to justify your choices, but youre practiced at that sort of thing by now.

The last four algorithms are dimensionality reduction algorithms:

PCA
ICA
Randomized Projections
Any other feature selection algorithm you desire
You are to run a number of experiments. Come up with at least two datasets. If youd like (and it makes a lot of sense in this case) you can use the ones you used in the first assignment or, if it makes any sense, the first part of this assignment.

Run the clustering algorithms on the data sets and describe what you see.
Apply the dimensionality reduction algorithms to the two datasets and describe what you see.
Reproduce your clustering experiments, but on the data after you've run dimensionality reduction on it.
Apply the dimensionality reduction algorithms to one of your datasets from assignment #1 (if you've reused the datasets from assignment #1 to do experiments 1-3 above then you've already done this) and rerun your neural network learner on the newly projected data.
Apply the clustering algorithms to the same dataset to which you just applied the dimensionality reduction algorithms (you've probably already done this), treating the clusters as if they were new features. In other words, treat the clustering algorithms as if they were dimensionality reduction algorithms. Again, rerun your neural network learner on the newly projected data.

What to Turn In

You must submit a tar or zip file named yourgtaccount.{zip,tar,tar.gz} in t-square that contains a single folder or directory named yourgtaccount that in turn contains: -->

A file named README.txt that contains instructions for running your code
your code
a file named yourgtaccount-analysis.pdf that contains your writeup.
any supporting files you need (for example, your datasets).
The file analysis.pdf should contain: 

Part 1


the results you obtained running the algorithms on the networks: why did you get the results you did? what sort of changes might you make to each of those algorithms to improve performance? Feel free to include any supporting graphs or tables. And by "feel free to", of course, I mean "do".
a description of your optimization problems, and why you feel that they are interesting and exercise the strengths and weaknesses of each approach. Think hard about this.
analyses of your results. Why did you get the results you did? Compare and contrast the different algorithms. What sort of changes might you make to each of those algorithms to improve performance? How fast were they in terms of wall clock time? Iterations? Which algorithm performed best? How do you define best? Be creative and think of as many questions you can, and as many answers as you can. You know the drill.
 

Part 2
a discussion of your datasets, and why they're interesting: If you're using the same datasets as before at least briefly remind us of what they are so we don't have to revisit your old assignment write-up.
explanations of your methods: How did you choose k?
a description of the kind of clusters that you got.
analyses of your results. Why did you get the clusters you did? Do they make "sense"? If you used data that already had labels (for example data from a classification problem from assignment #1) did the clusters line up with the labels? Do they otherwise line up naturally? Why or why not? Compare and contrast the different algorithms. What sort of changes might you make to each of those algorithms to improve performance? How much performance was due to the problems you chose? Be creative and think of as many questions you can, and as many answers as you can. Take care to justify your analysis with data explictly.
Can you describe how the data look in the new spaces you created with the various aglorithms? For PCA, what is the distribution of eigenvalues? For ICA, how kurtotic are the distributions? Do the projection axes for ICA seem to capture anything "meaningful"? Assuming you only generate k projections (i.e., you do dimensionality reduction), how well is the data reconstructed by the randomized projections? PCA? How much variation did you get when you re-ran your RP several times (I know I don't have to mention that you might want to run RP many times to see what happens, but I hope you forgive me)?
When you reproduced your clustering experiments on the datasets projected onto the new spaces created by ICA, PCA and RP, did you get the same clusters as before? Different clusters? Why? Why not?
When you re-ran your neural network algorithms were there any differences in performance? Speed? Anything at all?
It might be difficult to generate the same kinds of graphs for this part of the assignment as you did before; however, you should come up with some way to describe the kinds of clusters you get. If you can do that visually all the better. 


Note: Analysis writeup is limited to 20 pages total.
 

Grading Criteria

At this point you are not surprised to read that you are being graded on your analysis more than anything else. I will refer you to this section from assignment #1 for a more detailed explanation. On the other hand, I will also point out that implementing some of these algorithms is very easy (almost not worth stealing the code, but feel free to do so anyway) but at least one of them requires some time (luckily, there are now versions of this algorithm out there to steal). You should start now.
