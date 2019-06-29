defmodule Exnoops.API do
  @moduledoc false

  def test do
    quote do
      import Exnoops.BaseInMemory
    end
  end

  def prod do
    quote do
      import Exnoops.Base
    end
  end

  def dev do
    quote do
      import Exnoops.Base
    end
  end

  defmacro __using__(_) do
    apply(__MODULE__, Mix.env(), [])
  end
end
