TRCFILENAMES={ ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30731117.trc', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30731149.trc', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30801111.trc', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30801148.trc', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30803100.trc', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30803106.trc', ... 
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30803132.trc' ...
};

INDFILENAMES={ ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30731117.ind', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30731149.ind', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30801111.ind', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30801148.ind', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30803100.ind', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30803106.ind', ... 
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30803132.ind' ...
};

PGAPFILENAMES={ ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30731117.pgap', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30731149.pgap', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30801111.pgap', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30801148.pgap', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30803100.pgap', ...
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30803106.pgap', ... 
  '/home/zhanli/Workspace/data/field/brisbane2013-TRAC/30803132.pgap' ...
};

for i=1:length(TRCFILENAMES)
    intrcfile=TRCFILENAMES{i}; 
    ingoodindfile=INDFILENAMES{i}; 
    outpgapfile=PGAPFILENAMES{i}; 
    run script_ppfd2pgap;
    fprintf('%s finished\n', intrcfile);
end
