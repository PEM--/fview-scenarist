Utility = famous.utilities.Utility
OptionsManager = famous.core.OptionsManager

Views = famous.core.Views
Modifier = famous.core.Modifier
Surface = famous.core.Surface
Transform = famous.core.Transform

class BaseScenarist
  @DEFAULT_OPTIONS: {}
  constructor: (options) ->
    @_options = Utility.clone @constructor.DEFAULT_OPTIONS or \
      BaseScenarist.DEFAULT_OPTIONS

class Timeline extends BaseScenarist
  @DEFAULT_OPTIONS:
    timestamps: [
      {
        begin: 0
        duration: 1
        transform:
          start: Transform.identity
          end: Tansform.identity
      }
    ]
  constructor: (@name, @_options) ->
    super @_options
    # Calculate end of each timestamps
    t.end = t.begin + t.duration for t in @_options.timestamps
  getEnd: ->
    # TODO add a better algorithm in case timestamps are not sorted
    (_.last @_options.timestamps).end

class Scenarist extends BaseScenarist
  @DEFAULT_OPTIONS:
    duration: 0
  constructor: (@_options) ->
    super @_options
    @_timelines = {}
  add: (timeline) ->
    # Store timelime by its name
    @_timelines[timeline.name] = timeline
    # Adjust scenarist global duration
    if timeline.getEnd() > @_options.duration
      @_options.duration = timeline.getEnd()

class Puppet extends Views
  constructor: (idx, scenarist) ->
    @name = "puppet#{idx}"
    @timeline = new Timeline @name,
      timestamps: [
        {
          begin: idx
          duration: 3*idx
          transform:
            start: Transform.translate [100*(idx-1), 0]
            end: Transform.translate [100*(idx-1), 100*idx]
        }
      ]
    scenarist.add @timeline
    @mod = new Modifier transform: => @timeline.get()
    @surf = new Surface
      size: [150, 100]
      content: @name
    @mod.add @surf

scenarist = new Scenarist
puppet1 = new Puppet 1, scenarist
puppet2 = new Puppet 2, scenarist
console.log 'Start'
scenarist.start -> console.log 'End'
