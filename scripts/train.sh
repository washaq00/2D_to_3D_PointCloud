for r in {1..25}; do
	python3 train.py --group=0 --model=orig-ft --arch=original --load=orig-pre_it200000 --lr=5e-6 --fromIt=$((($r-1)*4000)) --toIt=$(($r*4000));
done