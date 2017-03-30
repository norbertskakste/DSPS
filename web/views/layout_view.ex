defmodule Dsps.LayoutView do
  use Dsps.Web, :view
  use Timex

  def logged_in_time(logged_in) do
    date = Timex.parse!(logged_in, "%FT%T%:z", :strftime)
    Timex.Comparable.diff(Timex.now, date, :seconds)
  end
end
