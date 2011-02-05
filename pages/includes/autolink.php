<?php
function replace_urls_callback($text, $callback) {
	// Start off with a regex
	preg_match_all('#(?:(?:https?|ftps?)://[^.\s]+\.[^\s]+|(?:[^.\s/]+\.)+(?:museum|travel|[a-z]{2,4})(?:[:/][^\s]*)?)#i', $text, $matches);
	
	// Then clean up what the regex left behind
	$offset = 0;
	foreach($matches[0] as $url) {
		$url = htmlspecialchars_decode($url);
		
		// Remove trailing punctuation
		$url = rtrim($url, '.?!,;:\'"`');

		// Remove surrounding parens and the like
		preg_match('/[)\]>]+$/', $url, $trailing);
		if (isset($trailing[0])) {
			preg_match_all('/[(\[<]/', $url, $opened);
			preg_match_all('/[)\]>]/', $url, $closed);
			$unopened = count($closed[0]) - count($opened[0]);

			// Make sure not to take off more closing parens than there are at the end
			$unopened = ($unopened > strlen($trailing[0])) ? strlen($trailing[0]):$unopened;

			$url = ($unopened > 0) ? substr($url, 0, $unopened * -1):$url;
		}

		// Remove trailing punctuation again (in case there were some inside parens)
		$url = rtrim($url, '.?!,;:\'"`');
		
		// Make sure we didn't capture part of the next sentence
		preg_match('#((?:[^.\s/]+\.)+)(museum|travel|[a-z]{2,4})#i', $url, $url_parts);
		
		// Were the parts capitalized any?
		$last_part = (strtolower($url_parts[2]) !== $url_parts[2]) ? true:false;
		$prev_part = (strtolower($url_parts[1]) !== $url_parts[1]) ? true:false;
		
		// If the first part wasn't cap'd but the last part was, we captured too much
		if ((!$prev_part && $last_part)) {
			$url = substr_replace($url, '', strpos($url, '.'.$url_parts[2], 0));
		}
		
		// Capture the new TLD
		preg_match('#((?:[^.\s/]+\.)+)(museum|travel|[a-z]{2,4})#i', $url, $url_parts);
		
		$tlds = array('ac', 'ad', 'ae', 'aero', 'af', 'ag', 'ai', 'al', 'am', 'an', 'ao', 'aq', 'ar', 'arpa', 'as', 'asia', 'at', 'au', 'aw', 'ax', 'az', 'ba', 'bb', 'bd', 'be', 'bf', 'bg', 'bh', 'bi', 'biz', 'bj', 'bm', 'bn', 'bo', 'br', 'bs', 'bt', 'bv', 'bw', 'by', 'bz', 'ca', 'cat', 'cc', 'cd', 'cf', 'cg', 'ch', 'ci', 'ck', 'cl', 'cm', 'cn', 'co', 'com', 'coop', 'cr', 'cu', 'cv', 'cx', 'cy', 'cz', 'de', 'dj', 'dk', 'dm', 'do', 'dz', 'ec', 'edu', 'ee', 'eg', 'er', 'es', 'et', 'eu', 'fi', 'fj', 'fk', 'fm', 'fo', 'fr', 'ga', 'gb', 'gd', 'ge', 'gf', 'gg', 'gh', 'gi', 'gl', 'gm', 'gn', 'gov', 'gp', 'gq', 'gr', 'gs', 'gt', 'gu', 'gw', 'gy', 'hk', 'hm', 'hn', 'hr', 'ht', 'hu', 'id', 'ie', 'il', 'im', 'in', 'info', 'int', 'io', 'iq', 'ir', 'is', 'it', 'je', 'jm', 'jo', 'jobs', 'jp', 'ke', 'kg', 'kh', 'ki', 'km', 'kn', 'kp', 'kr', 'kw', 'ky', 'kz', 'la', 'lb', 'lc', 'li', 'lk', 'lr', 'ls', 'lt', 'lu', 'lv', 'ly', 'ma', 'mc', 'md', 'me', 'mg', 'mh', 'mil', 'mk', 'ml', 'mm', 'mn', 'mo', 'mobi', 'mp', 'mq', 'mr', 'ms', 'mt', 'mu', 'museum', 'mv', 'mw', 'mx', 'my', 'mz', 'na', 'name', 'nc', 'ne', 'net', 'nf', 'ng', 'ni', 'nl', 'no', 'np', 'nr', 'nu', 'nz', 'om', 'org', 'pa', 'pe', 'pf', 'pg', 'ph', 'pk', 'pl', 'pm', 'pn', 'pr', 'pro', 'ps', 'pt', 'pw', 'py', 'qa', 're', 'ro', 'rs', 'ru', 'rw', 'sa', 'sb', 'sc', 'sd', 'se', 'sg', 'sh', 'si', 'sj', 'sk', 'sl', 'sm', 'sn', 'so', 'sr', 'st', 'su', 'sv', 'sy', 'sz', 'tc', 'td', 'tel', 'tf', 'tg', 'th', 'tj', 'tk', 'tl', 'tm', 'tn', 'to', 'tp', 'tr', 'travel', 'tt', 'tv', 'tw', 'tz', 'ua', 'ug', 'uk', 'us', 'uy', 'uz', 'va', 'vc', 've', 'vg', 'vi', 'vn', 'vu', 'wf', 'ws', 'ye', 'yt', 'yu', 'za', 'zm', 'zw');

		if (!in_array($url_parts[2], $tlds)) continue;
		
		// Call user specified func
		$modified_url = $callback($url);
		
		// Replace it!
		$start = strpos($text, $url, $offset);
		$text = substr_replace($text, $modified_url, $start, strlen($url));
		$offset = $start + strlen($modified_url);
	}
	
	return $text;
}

function linkify($url) {
	if (!preg_match('#^[a-z]+://#i', $url)) {
		return "<a href=\"http://$url\" class=\"extlink\" target=\"_blank\">$url</a>";
	}
	return "<a href=\"$url\" class=\"extlink\" target=\"_blank\">$url</a>";
}
?>