{
  virtualisation.docker = {
    enable = true;
  };

  users.users.ejg.extraGroups = [ "docker" ];
}
