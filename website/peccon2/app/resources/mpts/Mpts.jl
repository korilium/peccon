module Mpts

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Mpt

@kwdef mutable struct Mpt <: AbstractModel
  id::DbId = DbId()
  ticker::String = ""
  timestamp::String = ""
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
