module Movies

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Movie 

@kwdef mutable struct Movy <: AbstractModel
  id::DbId = DbId()
end

end
