# Personalized suggestions via Outliers

The file "MyKeyWords.m" reads "AllMyAbstracts.txt", extracts keywords from there (from allKW201712Collaps_Deg0Removed.mat), and compares to concept-useage on average (papers that used this concept, in nums2017.mat). That leads to a personalized interest, in the paper its called $r_{Scientist}(c_i)$.

It then executes "ApplyToFutureANL.m", which prepares the information of all concept pairs (where one is from the list of the researcher's interest list from above), and evaluates the degree, cosine similarity and SemNet predictions of these values (using EvalData2017.mat, which is large, as it contains 6000^2 entries with many properties each). Using this personalized subnetwork of SemNet, we can calculate outliers (largest distance from the center), which can be restricted in all sort of ways (as explained in the paper).
