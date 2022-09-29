# Colors

Basic running of the progam is an outline as follows:

iex(188)> server_j = Colors.judge                                                        
#PID<0.1292.0>
iex(189)> server_r = Colors.right                                                        
#PID<0.1294.0>
iex(190)> server_l = Colors.left                                                         
#PID<0.1296.0>
iex(191)> send(server_j, %{user: user, left: server_l, right: server_r, judge: server_j})
%{
  judge: #PID<0.1292.0>,
  left: #PID<0.1296.0>,
  right: #PID<0.1294.0>,
  user: #PID<0.159.0>
}
iex(192)> send(server_j, {:user, self()})                                                
{:user, #PID<0.159.0>}
iex(193)> flush
{:return, :sent}
{:server_l, :here}
{:server_r, :here}
[
  {:judge, #PID<0.1292.0>},
  "left score is 1 and right score is 2",
  {:left, [:purple, :white]},
  {:right, [:green, :green, :green]},
  {:judge, [:purple, :green, :purple], :right_last_guess, :green}
]
:ok


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `colors` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:colors, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/colors>.

# colors
