single_node:
	iex --sname s1 -S mix

named_node:
	MIX_ENV=dev_$(N) iex --name dev_$(N)@127.0.0.1 -S mix
	# MIX_ENV=dev_$(N) iex --sname dev_$(N) -S mix
