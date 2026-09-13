import { existsSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, isAbsolute, join, relative, resolve } from "node:path";
import type { ExtensionAPI, Theme } from "@earendil-works/pi-coding-agent";
import { CONFIG_DIR_NAME, VERSION, getAgentDir } from "@earendil-works/pi-coding-agent";
import { truncateToWidth } from "@earendil-works/pi-tui";

const GLOBAL_AGENT_DIR = getAgentDir();

function parentDirsFromRoot(cwd: string): string[] {
	const dirs: string[] = [];
	let current = resolve(cwd);
	while (true) {
		dirs.push(current);
		const parent = dirname(current);
		if (parent === current) break;
		current = parent;
	}
	return dirs.reverse();
}

function firstExisting(paths: string[]): string | undefined {
	return paths.find((path) => existsSync(path));
}

function discoverContextFiles(cwd: string, includeProjectConfig: boolean): string[] {
	const files: string[] = [];

	for (const file of ["SYSTEM.md", "APPEND_SYSTEM.md", "AGENTS.md"]) {
		const path = join(GLOBAL_AGENT_DIR, file);
		if (existsSync(path)) files.push(path);
	}

	if (includeProjectConfig) {
		for (const file of ["SYSTEM.md", "APPEND_SYSTEM.md"]) {
			const path = join(cwd, CONFIG_DIR_NAME, file);
			if (existsSync(path)) files.push(path);
		}
	}

	for (const dir of parentDirsFromRoot(cwd)) {
		const path = firstExisting([
			join(dir, "AGENTS.override.md"),
			join(dir, "AGENTS.md"),
			join(dir, "CLAUDE.md"),
		]);
		if (path) files.push(path);
	}

	return [...new Set(files)];
}

function formatPath(path: string, cwd: string): string {
	const rel = relative(cwd, path);
	if (rel && !rel.startsWith("..") && !isAbsolute(rel)) return rel;

	const home = homedir();
	if (path.startsWith(home + "/")) return `~/${path.slice(home.length + 1)}`;

	return path;
}

function renderHeader(theme: Theme, cwd: string, includeProjectConfig: boolean, width: number): string[] {
	const title = `${theme.bold(theme.fg("accent", "Pi"))}${theme.fg("dim", ` v${VERSION}`)}`;
	const contextFiles = discoverContextFiles(cwd, includeProjectConfig);

	const lines = ["", title];
	if (contextFiles.length === 0) {
		lines.push(theme.fg("dim", "Context: none"));
	} else {
		lines.push(theme.fg("mdHeading", "Context:"));
		for (const path of contextFiles) {
			lines.push(theme.fg("dim", `  ${formatPath(path, cwd)}`));
		}
	}
	lines.push("");

	return lines.map((line) => truncateToWidth(line, width));
}

export default function (pi: ExtensionAPI) {
	pi.on("session_start", (_event, ctx) => {
		if (ctx.mode !== "tui") return;

		const includeProjectConfig = ctx.isProjectTrusted();
		ctx.ui.setHeader((_tui, theme) => ({
			render: (width: number) => renderHeader(theme, ctx.cwd, includeProjectConfig, width),
			invalidate() {},
		}));
	});
}
