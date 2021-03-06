defmodule PhEctoAcl.TableActionAgent do
  defmacro __using__(options) do
    quote do
      use Agent

      # TODO: add tests about all of the accessible methods

      @table_action_schema unquote(options)[:table_action_schema]
      @repo unquote(options)[:repo]

      if !@table_action_schema do
        raise "please define table_action_schema when using table action agent"
      end

      if !@repo do
        raise "please define repo when using table action agent"
      end

      def start_link(_opts) do
        Agent.start_link(fn -> __MODULE__.seed() end, name: __MODULE__)
      end

      # Load from database
      def seed() do
        for e <- @repo.all(@table_action_schema), into: %{}, do: {[e.method] ++ [e.table], e}
      end

      # Load from database
      def refresh() do
        get_and_reset(seed())
      end

      @doc "Marks a task as executed"
      def put(key, value) do
        Agent.update(__MODULE__, &Map.put_new(&1, key, value))
      end

      def get() do
        Agent.get(__MODULE__, & &1)
      end

      def get(key) do
        Agent.get(__MODULE__, &Map.get(&1, key))
      end

      @doc "Resets the executed tasks and returns the previous list of tasks"
      def get_and_reset(value \\ %{}) do
        Agent.get_and_update(__MODULE__, fn list -> {list, value} end)
      end

      def stop() do
        Agent.stop(__MODULE__)
      end

      defoverridable seed: 0
    end
  end
end
