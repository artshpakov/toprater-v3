class IndexController < ApplicationController

  layout false

  skip_before_filter :set_sphere

end
