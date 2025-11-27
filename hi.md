# To run reflection-attack check:
make sigma=1 m4="-D noFlat -D noCol -D refl -D noRole"

# To run the "simple CPC" check:
make sigma=1 m4="-D noFlat -D noRole"

# To run the hash-transcript / CPC heavy check:
make sigma=1 m4="-D 4-3"

# To run the "most powerful attacker" default mentioned:
make sigma=1 m4="-D allFlat
"
# or with a bounded collapse size:
make sigma=1 m4="-D allFlat=5