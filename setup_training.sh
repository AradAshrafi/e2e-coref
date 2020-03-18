#!/bin/bash

dlx() {
  wget $1/$2
  tar -xvzf $2
  rm $2
}

#conll_url=http://conll.cemantix.org/2012/download
#dlx $conll_url conll-2012-train.v4.tar.gz
#dlx $conll_url conll-2012-development.v4.tar.gz
#dlx $conll_url/test conll-2012-test-key.tar.gz
#dlx $conll_url/test conll-2012-test-official.v9.tar.gz
#
#dlx $conll_url conll-2012-scripts.v3.tar.gz

# rm -rf './conll-2012/v4/data/train/data/arabic'
# rm -rf './conll-2012/v4/data/train/data/chinese'
# rm -rf './conll-2012/v4/data/development/data/arabic'
# rm -rf './conll-2012/v4/data/development/data/chinese'

#dlx http://conll.cemantix.org/download reference-coreference-scorers.v8.01.tar.gz
#mv reference-coreference-scorers conll-2012/scorer
#
#ontonotes_path='/content/drive/My Drive/ontonotes-release-5.0'
#echo "flag1111111111111"
#bash '/content/drive/My Drive/ontonotes-release-5.0/skeleton2conll_onlyEnglish.sh' -D '/content/drive/My Drive/ontonotes-release-5.0/data/files/data' '/content/e2e-coref/conll-2012/'
#echo $?
#echo "flag22222222222222"

function compile_partition() {
    rm -f $2.$5.$3$4
    cat conll-2012/$3/data/$1/data/$5/annotations/*/*/*/*.$3$4 >> $2.$5.$3$4
}

function compile_language() {
    compile_partition development dev v4 _gold_conll $1
    compile_partition train train v4 _gold_conll $1
    compile_partition test test v4 _gold_conll $1
}

#compile_language english
#compile_language chinese
#compile_language arabic
# compile_language persian

# python minimize.py
python get_char_vocab.py

python filter_embeddings.py cc.fa.300.vec train.persian.jsonlines dev.persian.jsonlines
python cache_elmo.py train.persian.jsonlines dev.persian.jsonlines
