set -e

inputs=(sha1.hex)

#inputs=$(ls input_data/evmcode/*.hex | xargs -n 1 basename)
for x in $inputs; do
    input_data=input_data/input_vectors/${x/.hex/}-inputs.json
    n=$(cat "$input_data" | jq 'length')
    y=0
    while [ $y -lt $n ]; do
        evm --code $(<input_data/evmcode/$x) --input $(cat $input_data | jq ".[$y].input" -r) --gas 0xffffff run
        ((y++));
    done
done

                                                           
