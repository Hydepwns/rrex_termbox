defmodule ExTermbox.Constants do
  @moduledoc """
  Defines constants from the termbox2 library. These can be used e.g. to set
  formatting attributes, colors, input/output modes, or to identify keys passed
  in an event.

  Values are based on termbox2 v2.5.0 (or compatible).
  """

  import Bitwise

  @type constant :: integer

  @type key :: constant
  @keys %{
    f1: 0xFFFF - 0,
    f2: 0xFFFF - 1,
    f3: 0xFFFF - 2,
    f4: 0xFFFF - 3,
    f5: 0xFFFF - 4,
    f6: 0xFFFF - 5,
    f7: 0xFFFF - 6,
    f8: 0xFFFF - 7,
    f9: 0xFFFF - 8,
    f10: 0xFFFF - 9,
    f11: 0xFFFF - 10,
    f12: 0xFFFF - 11,
    insert: 0xFFFF - 12,
    delete: 0xFFFF - 13,
    home: 0xFFFF - 14,
    end: 0xFFFF - 15,
    pgup: 0xFFFF - 16,
    pgdn: 0xFFFF - 17,
    arrow_up: 0xFFFF - 18,
    arrow_down: 0xFFFF - 19,
    arrow_left: 0xFFFF - 20,
    arrow_right: 0xFFFF - 21,
    back_tab: 0xFFFF - 22,
    mouse_left: 0xFFFF - 23,
    mouse_right: 0xFFFF - 24,
    mouse_middle: 0xFFFF - 25,
    mouse_release: 0xFFFF - 26,
    mouse_wheel_up: 0xFFFF - 27,
    mouse_wheel_down: 0xFFFF - 28,
    ctrl_tilde: 0x00,
    ctrl_2: 0x00,
    ctrl_a: 0x01,
    ctrl_b: 0x02,
    ctrl_c: 0x03,
    ctrl_d: 0x04,
    ctrl_e: 0x05,
    ctrl_f: 0x06,
    ctrl_g: 0x07,
    backspace: 0x08,
    ctrl_h: 0x08,
    tab: 0x09,
    ctrl_i: 0x09,
    ctrl_j: 0x0A,
    ctrl_k: 0x0B,
    ctrl_l: 0x0C,
    enter: 0x0D,
    ctrl_m: 0x0D,
    ctrl_n: 0x0E,
    ctrl_o: 0x0F,
    ctrl_p: 0x10,
    ctrl_q: 0x11,
    ctrl_r: 0x12,
    ctrl_s: 0x13,
    ctrl_t: 0x14,
    ctrl_u: 0x15,
    ctrl_v: 0x16,
    ctrl_w: 0x17,
    ctrl_x: 0x18,
    ctrl_y: 0x19,
    ctrl_z: 0x1A,
    esc: 0x1B,
    ctrl_lsq_bracket: 0x1B,
    ctrl_3: 0x1B,
    ctrl_4: 0x1C,
    ctrl_backslash: 0x1C,
    ctrl_5: 0x1D,
    ctrl_rsq_bracket: 0x1D,
    ctrl_6: 0x1E,
    ctrl_7: 0x1F,
    ctrl_slash: 0x1F,
    ctrl_underscore: 0x1F,
    space: 0x20,
    backspace2: 0x7F,
    ctrl_8: 0x7F
  }

  @type color :: constant
  @colors %{
    default: 0x00,
    black: 0x01,
    red: 0x02,
    green: 0x03,
    yellow: 0x04,
    blue: 0x05,
    magenta: 0x06,
    cyan: 0x07,
    white: 0x08
  }

  @type attribute :: constant
  @attributes %{
    bold: 0x0100,
    underline: 0x0200,
    reverse: 0x0400,
    italic: 0x0800,
    blink: 0x1000,
    hi_black: 0x2000,
    bright: 0x4000,
    dim: 0x8000
  }

  @type modifier :: constant
  @modifiers %{
    none: 0,
    alt: 1,
    ctrl: 2,
    shift: 4,
    motion: 8
  }

  @type event_type :: constant
  @event_types %{
    key: 1,
    resize: 2,
    mouse: 3
  }

  @type error_code :: constant
  @error_codes %{
    ok: 0,
    error: -1,
    need_more: -2,
    init_already: -3,
    init_open: -4,
    mem: -5,
    no_event: -6,
    no_term: -7,
    not_init: -8,
    out_of_bounds: -9,
    read: -10,
    resize_ioctl: -11,
    resize_pipe: -12,
    resize_sigaction: -13,
    poll: -14,
    tcgetattr: -15,
    tcsetattr: -16,
    unsupported_term: -17,
    resize_write: -18,
    resize_poll: -19,
    resize_read: -20,
    resize_sscanf: -21,
    cap_collision: -22
  }

  @type input_mode :: constant
  @input_modes %{
    current: 0,
    esc: 1,
    alt: 2,
    mouse: 4,
    esc_with_mouse: 1 ||| 4,
    alt_with_mouse: 2 ||| 4
  }

  @type output_mode :: constant
  @output_modes %{
    current: 0,
    normal: 1,
    term_256: 2,
    term_216: 3,
    grayscale: 4,
    truecolor: 5
  }

  @type hide_cursor :: constant
  @hide_cursor -1

  @doc """
  Retrieves the mapping of key constants for use with termbox2.

  These are based on terminfo constants. Note that there's some overlap
  of terminfo values. For example, it's not possible to distinguish between
  `<backspace>` and `ctrl-h`.
  """
  @spec keys() :: %{atom => key}
  def keys, do: @keys

  @doc """
  Retrieves a key constant by name

  ## Examples

      iex> key(:esc)
      0x1B
      iex> key(:space)
      0x20
      iex> key(:back_tab)
      #{0xFFFF - 22}

  """
  @spec key(atom) :: key
  def key(name), do: Map.fetch!(@keys, name)

  @doc """
  Retrieves the mapping of color constants (basic 8 colors + default).
  """
  @spec colors() :: %{atom => color}
  def colors, do: @colors

  @doc """
  Retrieves a color constant by name

  ## Examples

      iex> color(:red)
      0x02
      iex> color(:blue)
      0x05

  """
  @spec color(atom) :: color
  def color(name), do: Map.fetch!(@colors, name)

  @doc """
  Retrieves the mapping of attribute constants (assuming 16-bit attributes).
  """
  @spec attributes() :: %{atom => attribute}
  def attributes, do: @attributes

  @doc """
  Retrieves an attribute constant by name

  ## Examples

      iex> attribute(:bold)
      0x0100
      iex> attribute(:underline)
      0x0200
      iex> attribute(:italic)
      0x0800

  """
  @spec attribute(atom) :: attribute
  def attribute(name), do: Map.fetch!(@attributes, name)

  @doc """
  Retrieves the mapping of event type constants.
  """
  @spec event_types() :: %{atom => event_type}
  def event_types, do: @event_types

  @doc """
  Retrieves an event type constant by name

  ## Examples

      iex> event_type(:key)
      0x01
      iex> event_type(:resize)
      0x02
      iex> event_type(:mouse)
      0x03

  """
  @spec event_type(atom) :: event_type
  def event_type(name), do: Map.fetch!(@event_types, name)

  @doc """
  Retrieves the mapping of modifier constants.
  """
  @spec modifiers() :: %{atom => modifier}
  def modifiers, do: @modifiers

  @doc """
  Retrieves a modifier constant by name

  ## Examples

      iex> mod(:alt)
      1
      iex> mod(:none)
      0
      iex> mod(:ctrl)
      2
      iex> mod(:motion)
      8

  """
  @spec mod(atom) :: modifier
  def mod(name), do: Map.fetch!(@modifiers, name)

  @doc """
  Retrieves the mapping of error code constants.
  """
  @spec error_codes() :: %{atom => error_code}
  def error_codes, do: @error_codes

  @doc """
  Retrieves an error code constant by name

  ## Examples

      iex> error_code(:unsupported_term)
      -17
      iex> error_code(:mem)
      -5
      iex> error_code(:ok)
      0

  """
  @spec error_code(atom) :: error_code
  def error_code(name), do: Map.fetch!(@error_codes, name)

  @doc """
  Retrieves the mapping of input mode constants.
  """
  @spec input_modes() :: %{atom => input_mode}
  def input_modes, do: @input_modes

  @doc """
  Retrieves an input mode constant by name

  ## Examples

      iex> input_mode(:esc)
      1
      iex> input_mode(:mouse)
      4
      iex> input_mode(:alt_with_mouse)
      6

  """
  @spec input_mode(atom) :: input_mode
  def input_mode(name), do: Map.fetch!(@input_modes, name)

  @doc """
  Retrieves the mapping of output mode constants.
  """
  @spec output_modes() :: %{atom => output_mode}
  def output_modes, do: @output_modes

  @doc """
  Retrieves an output mode constant by name

  ## Examples

      iex> output_mode(:normal)
      1
      iex> output_mode(:term_256)
      2
      iex> output_mode(:truecolor)
      5

  """
  @spec output_mode(atom) :: output_mode
  def output_mode(name), do: Map.fetch!(@output_modes, name)

  @doc """
  Retrieves the hide cursor constant.

  ## Examples

      iex> hide_cursor()
      -1

  """
  @spec hide_cursor() :: hide_cursor
  def hide_cursor, do: @hide_cursor

  @doc """
  Resolves a color atom (e.g., :red) or integer to its integer value.
  Returns the default color value if the input is invalid or not found.

  This primarily works for the basic 8 colors defined in `@colors`.
  For extended color modes (256, truecolor, etc.), pass the integer directly.
  Attributes can also be passed as integers and will be returned as-is.
  """
  @spec resolve_color(atom | integer | any) :: integer
  def resolve_color(color_input) when is_atom(color_input) do
    Map.get(@colors, color_input, @colors.default)
  end

  def resolve_color(color_input) when is_integer(color_input) do
    # Assume integer is already a valid color value or attribute bitmask
    color_input
  end

  def resolve_color(_other) do
    # Fallback for invalid types
    @colors.default
  end
end
