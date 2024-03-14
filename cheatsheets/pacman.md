# pacman cheatsheet

## Install

```bash
# Install Packages, Groups
# Groups: https://archlinux.org/groups/
pacman -S pkg1 extra/pkg2 ...

# Prefix Expansions
pacman -S noto-fonts{,-cjk,-emoji,-extra}

# Upgrade All
pacman -Syu

# Specify installation reasons
pacman -S --asdeps pkg
pacman -S --asexplicit pkg
# Change installation reason
pacman -D --asdeps pkg
```

## Remove

```bash
# Remove a package
pacman -R pkg

# Remove a package, configs
pacman -Rn pkg

# Remove a package, dependencies
pacman -Rsu pkg

# Remove a package, dependencies, dependants
pacman -Rsc pkg
```

## Query

```bash
# Query Database
pacman -Ss str regex_str ...

# Query Installed
pacman -Qs str regex_str ...

# Query Details
pacman -Qii pkg
```

## Dependencies

```bash
# Files installed by pkg
pacman -Fl pkg

# Verify the files installed by pkg
pacman -Qkk pkg

# File installed by which package?
pacman -Qo /sbin/whoami

# Which package owns file?
pacman -F whoami
```

## Orphans

```bash
# Orphans
pacman -Qdt

# Explicitly installed, but has no dependant
pacman -Qet
```

## Clean Up

```bash
pacman -Scc
```
