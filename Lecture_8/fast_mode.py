import itertools


def puzzle_input() -> dict:
    with open('input.txt') as f:
        return {
            layer: range_
            for layer, range_ in (
                map(int, row.strip().split(': ')) for row in f)}


def calc_scanner_pos(scanner_height: int, time_step: int) -> int:
    """
    Calculates the position of a scanner within its range at a
    given time step.
    """
    cycle_midpoint = scanner_height - 1
    full_cycle = cycle_midpoint * 2
    cycle_position = time_step % full_cycle
    return (
        cycle_position
        if cycle_position <= cycle_midpoint
        else full_cycle - cycle_position)


def caught_crossing(firewall: dict, width: int, t_start: int) -> bool:
    """Returns True if the packet is caught while crossing, otherwise False."""
    for pos in range(width):
        if pos in firewall:
            scanner_height = firewall[pos]
            scanner_pos = calc_scanner_pos(scanner_height, t_start + pos)
            if scanner_pos == 0:
                return True
    return False


def find_start(firewall: dict) -> int:
    width = max(firewall.keys()) + 1
    for t_start in itertools.count(0):
        if not caught_crossing(firewall, width, t_start):
            break
    return t_start


print(find_start(puzzle_input()))