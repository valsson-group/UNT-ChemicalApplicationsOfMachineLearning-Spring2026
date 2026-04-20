Lecture_Start=1
Lecture_End=22

colab_prefix="https://colab.research.google.com/github/valsson-group/UNT-ChemicalApplicationsOfMachineLearning-Spring2026/blob/main/"

LinksFile="Lectures.md"

if [[ -f ${LinksFile} ]]; then
  echo "Error ${LinksFile} already exist"
  exit
fi 

for i in `seq ${Lecture_Start} ${Lecture_End}`
do
  echo " "
  lecture=`ls | grep Lecture-${i}_`
  if [[ -z ${lecture} ]]; then
    lecture=`ls | grep Lecture-${i}-`
  fi
  date=`echo ${lecture} | sed "s/Lecture-${i}//" | sed "s/-/ /g" | sed "s/_/ /g"`
  echo ${date}

  if [[ -n ${lecture} ]]; then 
    notebooks=`ls ${lecture}/*.ipynb | grep -v Solutions | sed "s/${lecture}\///" `
    notebooks_solutions=`ls ${lecture}/*.ipynb | grep Solutions | sed "s/${lecture}\///" `
    colab="${colab_prefix}/${lecture}"
    File="${lecture}/Readme.md"
    if [[ -f ${File} ]]; then
      echo "${File} already exist; skipping"
      continue
    fi
    echo ${File}

    echo "## Lecture ${i} -${date}" > ${File}
    for nb in ${notebooks}
    do
      echo "- [${nb}](${colab}/${nb})" >> ${File}
    done
    for nb in ${notebooks_solutions}
    do
      echo "- [${nb}](${colab}/${nb})" >> ${File}
    done
  echo " " >> ${File}
  cat ${File} >> ${LinksFile}
    
  fi
done
