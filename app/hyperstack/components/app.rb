class App < HyperComponent
  include Hyperstack::Router
  render do
    SECTION() do
      Route('/', exact: true, mounts: Index)
      Route('/search/:id', mounts: Search)
    end
  end
end