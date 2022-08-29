library(edgeR)
library(ggrepel)

## Loading Data
setwd("C:\\Users\\Ariel\\Desktop")
huh=read.table("huhReadsPerGene.out.tab")[-c(1:4),-c(2:3)]
cortical=read.table('corticalReadsPerGene.out.tab')[-c(1:4),-c(2:3)]
panc=read.table('pancreas_ReadsPerGene.out.tab')[-c(1:4),-c(2:3)]
lung=read.table('alv2ReadsPerGene.out.tab')[-c(1:4),-c(2:3)]
macrophage=read.table('macrophage_newReadsPerGene.out.tab')[-c(1:4),-c(2:3)]
cardiomyocyte=read.table('cardiomyocyteReadsPerGene.out.tab')[-c(1:4),-c(2:3)]
hesc=read.csv('COUNT_RNAseq_for_individual_mutants.csv')[,c(2:4)]
colnames(hesc)=c("V1","gene_name","V4")

## Merging Data to one table
gene_length=read.csv('LENGTH.csv')
countsl=list(huh,cortical,panc,lung,macrophage,cardiomyocyte)
counts=purrr::reduce(countsl, function(x,y) merge(x,y,by="V1"))
counts$V1=gsub("\\..*","",counts$V1)
hesc$V1=gsub("\\..*","",hesc$V1)
counts=merge(counts,hesc, by="V1")
colnames(counts)=c('Gene_ID','Liver','Cortical','Pancreas','Lung','Macrophage','Cardiomyocyte',"gene_name", "hesc")

## TPM
group=c(1:7)
y=DGEList(counts[,c(2:7,9)], group=group,genes=counts[,c(1,8)])
keep = filterByExpr(y)
y = y[keep, , keep.lib.sizes=FALSE]
y = calcNormFactors(y)
cpm=cpm(y)
rownames(cpm)=y$genes$gene_name

gene_length$Gene.ID=gsub("\\..*","",gene_length$Gene.ID)
counts=merge(counts, gene_length, by.x="Gene_ID", by.y="Gene.ID")
tpm=function(counts, gene_length) {
  rate=counts/gene_length
  rate / sum(rate) * 1e6
}
finaltpm=tpm(counts[,c(2:7,9)],counts[,c(10)])
finaltpm=cbind(gene_name=counts$gene_name,finaltpm )

## top 150 genes list
topgenes=read.csv("Genome-scale identification of SARS-CoV-2 and pan-coronavirus host factor networks.csv", stringsAsFactors = F)
topgene=topgenes$ן..Gene[topgenes$Sig=='Sig']

## Score calculation for each tissue
topgenelist= finaltpm[finaltpm$gene_name%in%topgene,]
score=data.frame(tissue=names(finaltpm)[2:8], score=colSums(topgenelist[2:8]>1))

## t.test between infected/noninfected groups (literature)+ Boxplot
score$group=c("Infected","Not Infected","Infected","Infected","Not Infected","Infected","Not Infected")
ggplot(data = score, aes(x=group, y=score))+stat_boxplot() +theme_classic()

##outlier adjustment
p_val=t.test(score$score[c(3,4,6)], score$score[c(2,5,7)])
ggplot(data = score[2:7,], aes(x=group, y=score, label="p.val = 0.42",))+stat_boxplot() +theme_classic()+geom_text(aes(x=1.4,y=130))

##PCA plot of all tissues but liver
p=prcomp(t(topgenelist[-142,3:8]), scale. = T)
d=cbind(data.frame(p$x), name=rownames(p$x))
ggplot(data = d, aes(x=PC1, y=PC2, label=name))+geom_point()+ geom_text_repel()+theme_classic()

##Venn diagram for overlappping genes
Genetic_screeens=read.csv("Genetic Screens Identify Host Factors for SARS-CoV-2 and Common Cold Coronaviruses.csv", stringsAsFactors = F)
Identification_of=read.csv("Identification of Required Host Factors for SARSCoV-2 Infection in Human Cells.csv", stringsAsFactors = F)
Genome_scale=read.csv("Genome-scale identification of SARS-CoV-2 and pan-coronavirus host factor networks.csv", stringsAsFactors = F)
library(grid)
library(futile.logger)
library(VennDiagram)

set1 <- Genetic_screeens$ן..id[1:150]
set2 <- Identification_of$ן..gene_id[1:150]
set3 <- Genome_scale$ן..Gene[1:150]

library(RColorBrewer)
myCol <- brewer.pal(3, "Pastel2")

venn.diagram(
  x = list(set1, set2, set3),
  category.names = c("Wang et al" , "Daniloski et al" , "Schneider et al"),
  filename = '#14_venn_diagramm.png',
  output=TRUE,
  
  # Output features
  imagetype="png" ,
  height = 480 , 
  width = 480 , 
  resolution = 300,
  compression = "lzw",
  
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = myCol,
  
  # Numbers
  cex = .6,
  fontface = "bold",
  fontfamily = "sans",
  
  # Set names
  cat.cex = 0.6,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.pos = c(-27, 27, 135),
  cat.dist = c(0.055, 0.055, 0.085),
  cat.fontfamily = "sans",
  rotation = 1
)

## P value calculation for overlapped genes
dhyper(16,150,19350,150)
dhyper(1,150,19350,150)
dhyper(2,150,19350,150)
