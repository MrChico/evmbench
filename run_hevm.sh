set -e

#tests to run:
inputs=(sha1.hex)

for x in $inputs; do
    input_data=input_data/input_vectors/${x/.hex/}-inputs.json
    n=$(cat "$input_data" | jq 'length')
    y=0
    while [ $y -lt $n ]; do
        hevm exec --code $(<input_data/evmcode/$x) --calldata $(cat $input_data | jq ".[$y].input" -r) --gas 0xffffff
        ((y++));
    done
done

                                                           
