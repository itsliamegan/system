import { CustomEditor, type ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Key, matchesKey, visibleWidth } from "@earendil-works/pi-tui";

type EditorInternals = {
	lastAction: null;
	setCursorCol(column: number): void;
};

type VisualLine = {
	startIndex: number;
	endIndex: number;
};

const graphemeSegmenter = new Intl.Segmenter(undefined, { granularity: "grapheme" });
const cjkCharacter = /\p{Script=Han}|\p{Script=Hiragana}|\p{Script=Katakana}|\p{Script=Hangul}/u;

function wrapVisualLines(line: string, width: number): VisualLine[] {
	if (!line || width <= 0) return [{ startIndex: 0, endIndex: 0 }];
	if (visibleWidth(line) <= width) return [{ startIndex: 0, endIndex: line.length }];

	const graphemes = [...graphemeSegmenter.segment(line)];
	const visualLines: VisualLine[] = [];
	let visualLineStart = 0;
	let visualLineWidth = 0;
	let wrapOpportunityIndex = -1;
	let wrapOpportunityWidth = 0;

	for (let index = 0; index < graphemes.length; index++) {
		const grapheme = graphemes[index]!;
		const graphemeWidth = visibleWidth(grapheme.segment);

		if (visualLineWidth + graphemeWidth > width) {
			if (
				wrapOpportunityIndex >= 0 &&
				visualLineWidth - wrapOpportunityWidth + graphemeWidth <= width
			) {
				visualLines.push({ startIndex: visualLineStart, endIndex: wrapOpportunityIndex });
				visualLineStart = wrapOpportunityIndex;
				visualLineWidth -= wrapOpportunityWidth;
			} else if (visualLineStart < grapheme.index) {
				visualLines.push({ startIndex: visualLineStart, endIndex: grapheme.index });
				visualLineStart = grapheme.index;
				visualLineWidth = 0;
			}
			wrapOpportunityIndex = -1;
		}

		visualLineWidth += graphemeWidth;
		const nextGrapheme = graphemes[index + 1];
		const isWhitespace = /^\s$/u.test(grapheme.segment);
		const nextIsWhitespace = nextGrapheme ? /^\s$/u.test(nextGrapheme.segment) : false;
		if (isWhitespace && nextGrapheme && !nextIsWhitespace) {
			wrapOpportunityIndex = nextGrapheme.index;
			wrapOpportunityWidth = visualLineWidth;
		} else if (!isWhitespace && nextGrapheme && !nextIsWhitespace) {
			if (cjkCharacter.test(grapheme.segment) || cjkCharacter.test(nextGrapheme.segment)) {
				wrapOpportunityIndex = nextGrapheme.index;
				wrapOpportunityWidth = visualLineWidth;
			}
		}
	}

	visualLines.push({ startIndex: visualLineStart, endIndex: line.length });
	return visualLines;
}

/** Makes Ctrl-A and Ctrl-E move within the cursor's current wrapped line. */
class VisualLineEditor extends CustomEditor {
	private visualLineWidth = 79;

	handleInput(data: string): void {
		if (matchesKey(data, Key.ctrl("a"))) {
			this.moveToVisualLineBoundary("start");
			return;
		}

		if (matchesKey(data, Key.ctrl("e"))) {
			this.moveToVisualLineBoundary("end");
			return;
		}

		super.handleInput(data);
	}

	render(width: number): string[] {
		// CustomEditor uses this width when its default padding is zero.
		this.visualLineWidth = Math.max(1, width - 1);
		return super.render(width);
	}

	private moveToVisualLineBoundary(boundary: "start" | "end"): void {
		const cursor = this.getCursor();
		const currentLine = this.getLines()[cursor.line] ?? "";
		const visualLines = wrapVisualLines(currentLine, this.visualLineWidth);
		const currentVisualLine = visualLines.find((visualLine, index) => {
			const isLastVisualLine = index === visualLines.length - 1;
			return (
				cursor.col >= visualLine.startIndex &&
				(cursor.col < visualLine.endIndex || (isLastVisualLine && cursor.col === visualLine.endIndex))
			);
		});

		if (!currentVisualLine) return;

		// Editor has no public cursor setter. Call its internal helper so its
		// sticky-column state stays consistent with ordinary cursor movement.
		const editor = this as unknown as EditorInternals;
		editor.lastAction = null;
		editor.setCursorCol(boundary === "start" ? currentVisualLine.startIndex : currentVisualLine.endIndex);
	}
}

export default function (pi: ExtensionAPI) {
	pi.on("session_start", (_event, ctx) => {
		if (ctx.mode !== "tui") return;
		ctx.ui.setEditorComponent((tui, theme, keybindings) => new VisualLineEditor(tui, theme, keybindings));
	});
}
