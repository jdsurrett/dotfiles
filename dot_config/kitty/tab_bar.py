# pyright: reportMissingImports=false
import datetime

# from collections import defaultdict
from kitty.boss import (
    get_boss
)

from kitty.fast_data_types import (
    Screen,
    add_timer
)

from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_title,
)

from kitty.utils import color_as_int



timer_id = None

def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:

    global timer_id

    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, 1.0, True)
    _draw_left_status(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index, is_last,
        extra_data
    )
    if is_last:
        _draw_right_status(
            draw_data,
            screen
        )

    return screen.cursor.x



def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    a_tab_bg = as_rgb(int(draw_data.active_bg))
    # a_tab_fg = as_rgb(int(draw_data.active_fg))

    if draw_data.leading_spaces:
        screen.draw(" " * draw_data.leading_spaces)

    draw_title(draw_data, screen, tab, index)
    trailing_spaces = min(max_title_length - 1, draw_data.trailing_spaces)
    max_title_length -= trailing_spaces
    extra = screen.cursor.x - before - max_title_length
    
    if extra > 0:
        screen.cursor.x -= extra + 1
        screen.draw("…")
    
    if trailing_spaces:
        screen.draw(" " * trailing_spaces)
    
    end = screen.cursor.x 
    screen.cursor.bold = screen.cursor.italic = False
    screen.cursor.fg = 0
    
    if not is_last:
        screen.cursor.bg = as_rgb(color_as_int(draw_data.inactive_bg))
        screen.draw(draw_data.sep)
    
    screen.cursor.bg = 0
    screen.cursor.fg = a_tab_bg
    screen.draw("")
    
    return end



def _draw_right_status(draw_data: DrawData, screen: Screen) -> None:
    # The tabs may have left some formats enabled. Disable them now.
    draw_attributed_string(Formatter.reset, screen)
    cells = create_cells()
    # Drop cells that wont fit

    while True:
        if not cells:
            return
        padding = screen.columns - screen.cursor.x - sum(len(c) + 3 for c in cells)
        if padding >= 0:
            break
        cells = cells[1:]

    if padding:
        screen.draw(" " * padding)

    a_tab_bg = as_rgb(int(draw_data.active_bg))
    a_tab_fg = as_rgb(int(draw_data.active_fg))
    i_tab_bg = as_rgb(int(draw_data.inactive_bg))
    i_tab_fg = as_rgb(int(draw_data.inactive_fg))
    default_bg = as_rgb(int(draw_data.default_bg))
    for cell in cells:
        # Draw the separator
        if cell == cells[0]:
            screen.cursor.fg = a_tab_bg
            screen.draw("")
            screen.cursor.fg = a_tab_fg
            screen.cursor.bg = a_tab_bg
        else:
            screen.cursor.fg = default_bg
            screen.draw("")
            screen.cursor.fg = i_tab_fg
            screen.cursor.bg = i_tab_bg
        screen.draw(f" {cell} ")



def create_cells() -> list[str]:
    now = datetime.datetime.now()
    return [
        now.strftime("%a ┊ %D "),
        now.strftime("%I:%M %p "),
    ]



def _redraw_tab_bar(timer_id):
    for tm in get_boss(timer_id).all_tab_managers:
        tm.mark_tab_bar_dirty()
