library(ggpubr)

# d=read.table("${work_dir}/sj_3d/density_table_vs_all.csv")
d=read.table("${work_dir}/sj_3d/density_table_vs_all.csv")

names(d)<-c("sample","count","gene_count",'get_num')
d$vs="all"


d_key=read.table("${work_dir}/sj_3d/density_table_vs_key.csv")

names(d_key)<-c("sample","count","gene_count",'get_num')
lines<-data.frame(sample=c("scep","sjap","syun"),yy=c(17,21,14))
# texts<-data.frame(sample=c("scep","sjap","syun"),lab=c("p<0.001","p<0.001","p<0.001"))
d_key$vs="candidate"
d_mix<-rbind(d,d_key)
d_mix$type<-factor(paste(d_mix$sample,d_mix$vs,sep="_"),level=c("scep_candidate","scep_all","sjap_candidate","sjap_all","syun_candidate","syun_all"))

d_mix$vs<-factor(d_mix$vs,level=c("candidate","all"))




#######################################
### splited

p3<-ggplot(d_mix, aes(vs, count)) +
  geom_violin(adjust=1.5,aes(fill = vs),)+
  geom_boxplot(fill="white",width=0.5)+
  xlab("")+
    stat_boxplot(geom = "errorbar",
               width=0.2)+        
    ylab("TAD count")+
    xlab("Sample")+
    geom_hline(data=lines,aes(yintercept=yy),colour="red", linetype="dashed")+
    theme_pubr()+
    scale_y_continuous(limits=c(0,70),breaks=seq(0,70,10),expand=c(0,0))+
    theme(plot.margin = margin(t=0.3,l=0.2,unit="in"))+
    # stat_compare_means( method = "t.test",comparisons = list( c("candidate", "all")), label.y = c(60,65))+
    stat_compare_means( label.y = c(60,65),comparisons = list( c("candidate", "all")))



p3<-facet(p3, facet.by = "sample",        
        strip.position  = "bottom",
                scales = "free_y",
        panel.labs = list(
          sample =c(
            "Stephania cepharantha",
            "Stephania japonica",
            "Stephania yunnanensis"
            # expression(italic("Stephania cepharantha")),
            # expression( italic("Stephania japonica"))
            )
          ))+
    theme(axis.text.x = element_text(size = 8.5),
        strip.placement="outside",
        strip.background = element_blank(),
        strip.background.y = element_blank(),
        strip.text = element_text(face = "italic"),
    )+ 
    scale_fill_discrete(name="",labels = c("Ortholog","All"))
ggsave("${work_dir}/sj_3d/splited.pdf",p3,
width = 5,
height = 5.5,
units = "in")








