**Introduction:**

Severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2) is a highly transmissible and pathogenic coronavirus that emerged in late 2019. 
Since then, it has infected more than 100 million people worldwide.
Symptoms can vary from a mild flu-like symptoms up to severe acute respiratory, which has led to the death of over 2.3 million people worldwide (WHO Statistical Dashboard, 2021).
To better understand host-virus genetic dependencies and find potential therapeutic targets for COVID-19, a genome-scale CRISPR loss of function approach was performed by a group in the USA, hoping to identify host factors required for SARS-CoV-2 viral infection (Schneider et al, 2020).
The screen uncovered a list of 147 FDR significant genes that once knocked out, can result up to 50% decrease of infection compared to the same untreated with CRISPR cell type.
Surprisingly, ACE2, one of the most known and confirmed genes required for SARS-CoV-2 infection (Behnaz et al, 2021) did not show significant enrichment in the CRISPR essay.
This unexpected result shows that although genetic screening is indeed a powerful tool, it is still lacking somewhat of an error rate. In order to validate each of the whole 147 genes hits, one might test one by one for the infectivity of SARS-CoV-2 in 147 specific KO cell for each of the FDR significant found genes in Schneider et al paper.
This approach seems unreasonable and time consuming, furthermore a major downside is that the screen itself is usually done on one type of cell that might not always be suited for the inspected disease. 
In the following project I will try to address these issues by looking at the expression of the genes found at Schneider et al paper, in several different tissues and offer a statistical comparative method that will try to represent the reliability of the genes found. By doing that, we will be able to get a more intuitive feeling regarding the found genes. In some cases, this method could raise a ‘red flag’ suggesting that there might be a need for re-checking the results. 
In addition, this kind of comparative statistical approach can be also used in a variety of CRISPR loss-of-function experiments as a way to test for their reliability.
Methods:
In the following project I analyzed the gene expression of 7 different cell types derived from all 3 germ layers: Mesoderm- Macrophages and Cardiomyocytes, Endoderm- Pancreas, Liver and Lung, Ectoderm- Cortical neurons. In addition, human embryonic stem cells (hesc) were tested.
My raw data, RNA sequence for each of the tissues, was downloaded from the GEO database. 
For each sample, an alignment to the human genome was done with STAR algorithm using the cluster system of the Hebrew university. 
The resulted gene AA  normalized using TPM.
Then, the expression of each of the 147 genes found in Schneider et al paper were tested for each of the cell types described above, setting the threshold of expression to be of TPM 1.
A score that represent the expressed genes was attributed to each tissue, ranging from 0 (none of the 147 found genes were expressed) to 147 (all of the found genes are expressed).
Next on, using published literature, I divided the 7 different inspected tissues to two groups according to their infectability by SARS-CoV-2 -known to be infected and not known to be infected (according to literature hesc will be attributed to the non-infected group (Yang et al, 2020).
Following that, I conducted a t-test between the two groups, and checked if there is a significant difference between the score of each group.
Next, I performed a PCA essay on the different tissues, to see if the two different groups cluster separately.
Lastly, I compared the 147 genes found to additional two similar SARS-COV-2 genetic screen papers using hypergeometric distribution test.


**Methods:**
In the following project I analyzed the gene expression of 7 different cell types derived from all 3 germ layers: Mesoderm- Macrophages and Cardiomyocytes, Endoderm- Pancreas, Liver and Lung, Ectoderm- Cortical neurons. In addition, human embryonic stem cells (hesc) were tested.
My raw data, RNA sequence for each of the tissues, was downloaded from the GEO database. 
For each sample, an alignment to the human genome was done with STAR algorithm using the cluster system of the Hebrew university. 
The resulted gene AA  normalized using TPM.
Then, the expression of each of the 147 genes found in Schneider et al paper were tested for each of the cell types described above, setting the threshold of expression to be of TPM 1.
A score that represent the expressed genes was attributed to each tissue, ranging from 0 (none of the 147 found genes were expressed) to 147 (all of the found genes are expressed).
Next on, using published literature, I divided the 7 different inspected tissues to two groups according to their infectability by SARS-CoV-2 -known to be infected and not known to be infected (according to literature hesc will be attributed to the non-infected group (Yang et al, 2020).
Following that, I conducted a t-test between the two groups, and checked if there is a significant difference between the score of each group.
Next, I performed a PCA essay on the different tissues, to see if the two different groups cluster separately.
Lastly, I compared the 147 genes found to additional two similar SARS-COV-2 genetic screen papers using hypergeometric distribution test.

