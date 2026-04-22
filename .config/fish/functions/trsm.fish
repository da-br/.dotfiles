#!/usr/bin/env fish

function trsm -d "Manage Transmission torrents"
    set -l cmd $argv[1]
    
    switch $cmd
        case start
            echo "Starting transmission-daemon..."
            transmission-daemon -T
            
        case stop
            echo "Stopping transmission-daemon..."
            killall transmission-daemon
            
        case add
            if test (count $argv) -lt 2
                echo "Usage: trsm add <torrent-file-or-magnet-link>"
                return 1
            end
            transmission-remote --add $argv[2]
            
        case list ls
            transmission-remote --list
            
        case info
            if test (count $argv) -lt 2
                echo "Usage: trsm info <torrent-id>"
                return 1
            end
            transmission-remote --torrent $argv[2] --info
            
        case pause
            if test (count $argv) -lt 2
                echo "Usage: trsm pause <torrent-id|all>"
                return 1
            end
            if test "$argv[2]" = "all"
                transmission-remote --torrent all --stop
            else
                transmission-remote --torrent $argv[2] --stop
            end
            
        case resume
            if test (count $argv) -lt 2
                echo "Usage: trsm resume <torrent-id|all>"
                return 1
            end
            if test "$argv[2]" = "all"
                transmission-remote --torrent all --start
            else
                transmission-remote --torrent $argv[2] --start
            end
            
        case remove rm
            if test (count $argv) -lt 2
                echo "Usage: trsm resume <torrent-id|all>"
                return 1
            end
            if test "$argv[2]" = "all"
                transmission-remote --torrent all --remove
            else
                transmission-remote --torrent $argv[2] --remove
            end
            
        case delete
            if test (count $argv) -lt 2
                echo "Usage: trsm delete <torrent-id>"
                echo "This will remove the torrent AND delete downloaded files"
                return 1
            end
            transmission-remote --torrent $argv[2] --remove-and-delete
            
        case status
            transmission-remote --session-info
            
        case help -h --help
            echo "Transmission Manager (trsm) - Easy torrent management"
            echo ""
            echo "Usage: trsm <command> [arguments]"
            echo ""
            echo "Commands:"
            echo "  start              Start transmission-daemon"
            echo "  stop               Stop transmission-daemon"
            echo "  add <link>         Add torrent file or magnet link"
            echo "  list, ls           List all torrents"
            echo "  info <id>          Show detailed info for torrent"
            echo "  pause <id|all>     Pause torrent(s)"
            echo "  resume <id|all>    Resume torrent(s)"
            echo "  remove <id>        Remove torrent (keep files)"
            echo "  delete <id>        Remove torrent and delete files"
            echo "  status             Show daemon session info"
            echo "  help               Show this help message"
            
        case ''
            trsm help
            
        case '*'
            echo "Unknown command: $cmd"
            echo "Run 'trsm help' for usage information"
            return 1
    end
end
