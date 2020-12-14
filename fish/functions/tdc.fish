function tdc -d "Toggles docker context from local to mac ro"
  if ! contains default (docker context show)
    docker context use default
    kubectl config use-context docker-desktop
  else
    docker context use macpro
    kubectl config use-context macpro
  end
end
