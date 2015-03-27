note
	description: "Summary description for {IMAGE_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IMAGE_FACTORY

create
	make

feature {NONE}

	make
		do
			number_of_instances.put (number_of_instances.item + 1)
		end

	number_of_instances: CELL[INTEGER]
		once
			create Result.put(0)
		end

invariant
	unique_instance:number_of_instances.item = 1
end
