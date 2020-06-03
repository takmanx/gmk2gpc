# NAME

gmk2gpc

gmk2gpc.pl - Converts ConsoleTuner's GMK macro to GPC script.

# USAGE

```
usage: perl gmk2gpc.pl <input.gmk file>

output: gpc code
```
    

# SYNOPSIS

```
% perl ./gmk2gpc.pl sample.gmk
combo sample {
  set_val(BUTTON_3, 100.00);
  wait(32768);
  wait(1234);
  set_val(BUTTON_1, -100.00);
}
```

# DESCRIPTION

gmk2gpc is perl implementation for converting gmk macro to gpc script.


References

* https://github.com/PoshLemur/GPC2Macro Converts ConsoleTuner's GPC2 script into GMK macro.
* https://www.consoletuner.com/ ConsoleTuner Web site


# LICENSE

The MIT License (MIT)

Copyright (C) 2020 Yukio TAKAHASHI

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Yukio TAKAHASHI <takman@tuna.jpn.org>
