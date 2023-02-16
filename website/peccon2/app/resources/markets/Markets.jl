module Markets

import SearchLight: AbstractModel, DbId
import Base: @kwdef
import Dates: Date 

export Market

@kwdef mutable struct Market <: AbstractModel
  id::DbId = DbId()
  ticker::String = ""
  timestamp::Date = Date(1531,1,1)
  open::Float64 =0
  high::Float64 =0
  low::Float64 =0
  close::Float64 =0
  adjusted_close::Float64 = 0
  volume::Float64 = 0
  dividend_amount::Float64 = 0
  split_coefficient::Float64 = 0
end

end