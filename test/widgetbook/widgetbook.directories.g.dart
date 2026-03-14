// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

import 'stories/components/directory_component_story.dart'
    as _asset_moo_test_widgetbook_stories_components_directory_component_story;
import 'stories/components/grid_component_story.dart'
    as _asset_moo_test_widgetbook_stories_components_grid_component_story;
import 'stories/procgen_story.dart'
    as _asset_moo_test_widgetbook_stories_procgen_story;
import 'stories/screens/failure_screen_story.dart'
    as _asset_moo_test_widgetbook_stories_screens_failure_screen_story;
import 'stories/screens/login_screen_story.dart'
    as _asset_moo_test_widgetbook_stories_screens_login_screen_story;
import 'stories/screens/play_screen_story.dart'
    as _asset_moo_test_widgetbook_stories_screens_play_screen_story;
import 'stories/screens/success_screen_story.dart'
    as _asset_moo_test_widgetbook_stories_screens_success_screen_story;
import 'stories/widgets/alert_ticker_story.dart'
    as _asset_moo_test_widgetbook_stories_widgets_alert_ticker_story;
import 'stories/widgets/flasher_story.dart'
    as _asset_moo_test_widgetbook_stories_widgets_flasher_story;
import 'stories/widgets/terminal_button_story.dart'
    as _asset_moo_test_widgetbook_stories_widgets_terminal_button_story;
import 'stories/widgets/terminal_checkbox_story.dart'
    as _asset_moo_test_widgetbook_stories_widgets_terminal_checkbox_story;
import 'stories/widgets/terminal_header_story.dart'
    as _asset_moo_test_widgetbook_stories_widgets_terminal_header_story;
import 'stories/widgets/terminal_story.dart'
    as _asset_moo_test_widgetbook_stories_widgets_terminal_story;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookComponent(
    name: 'Procgen',
    useCases: [
      _widgetbook.WidgetbookUseCase(
        name: 'Default',
        builder:
            _asset_moo_test_widgetbook_stories_procgen_story.buildProcgenStory,
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'flame',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'components',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'DirectoryComponent',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _asset_moo_test_widgetbook_stories_components_directory_component_story
                        .buildDirectoryComponentStory,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'GridComponent',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _asset_moo_test_widgetbook_stories_components_grid_component_story
                        .buildGridComponentStory,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'screens',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'FailureScreen',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _asset_moo_test_widgetbook_stories_screens_failure_screen_story
                    .buildFailureScreenStory,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'LoginScreen',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _asset_moo_test_widgetbook_stories_screens_login_screen_story
                    .buildLoginScreenStory,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'PlayScreen',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _asset_moo_test_widgetbook_stories_screens_play_screen_story
                    .buildPlayScreenStory,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'SuccessScreen',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _asset_moo_test_widgetbook_stories_screens_success_screen_story
                    .buildSuccessScreenStory,
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'AlertTicker',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _asset_moo_test_widgetbook_stories_widgets_alert_ticker_story
                    .buildAlertTickerStory,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'Flasher',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _asset_moo_test_widgetbook_stories_widgets_flasher_story
                .buildFlasherStory,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'Terminal',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _asset_moo_test_widgetbook_stories_widgets_terminal_story
                .buildTerminalStory,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'TerminalButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _asset_moo_test_widgetbook_stories_widgets_terminal_button_story
                    .buildTerminalButtonStory,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'TerminalCheckbox',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _asset_moo_test_widgetbook_stories_widgets_terminal_checkbox_story
                    .buildTerminalCheckboxStory,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'TerminalHeader',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _asset_moo_test_widgetbook_stories_widgets_terminal_header_story
                    .buildTerminalHeaderStory,
          ),
        ],
      ),
    ],
  ),
];
