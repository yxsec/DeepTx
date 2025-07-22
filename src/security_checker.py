#!/usr/bin/env python3
"""
Malicious database query and fraud pattern detection script
Analyzes transaction output data in output/1/[tx_hash]/ directory
"""

import os
import json
import re
import pandas as pd
from typing import List, Dict, Set, Optional
from datetime import datetime

class MaliciousChecker:
    def __init__(self, database_dir: str = "malicious_database"):
        self.database_dir = database_dir
        self.malicious_addresses: Set[str] = set()
        self.malicious_domains: Set[str] = set()
        self.load_databases()
        
        # Fraud pattern rules - add specific detection rules here
        self.fraud_patterns = {
            # 'pattern_category': [r'regex_pattern1', r'regex_pattern2'],
            # 'reentrancy': [...],
            # 'access_control': [...],
            # 'suspicious_transfers': [...],
            # 'honeypot': [...]
        }

    def load_databases(self):
        """Load malicious addresses and domains database"""
        try:
            # Load malicious addresses
            addr_file = os.path.join(self.database_dir, "address.json")
            if os.path.exists(addr_file):
                with open(addr_file, 'r', encoding='utf-8') as f:
                    addresses = json.load(f)
                    self.malicious_addresses = {addr.lower() for addr in addresses}
                    print(f"Loaded {len(self.malicious_addresses)} malicious addresses")
            
            # Load malicious domains
            domain_file = os.path.join(self.database_dir, "domains.json")
            if os.path.exists(domain_file):
                with open(domain_file, 'r', encoding='utf-8') as f:
                    domains = json.load(f)
                    self.malicious_domains = {domain.lower() for domain in domains}
                    print(f"Loaded {len(self.malicious_domains)} malicious domains")
                    
        except Exception as e:
            print(f"Error loading malicious databases: {e}")

    def check_addresses(self, addresses: List[str]) -> Dict[str, bool]:
        """Check if addresses are malicious"""
        results = {}
        for addr in addresses:
            clean_addr = addr.lower().replace("0x", "")
            is_malicious = (clean_addr in self.malicious_addresses or 
                          f"0x{clean_addr}" in self.malicious_addresses)
            results[addr] = is_malicious
        return results

    def check_code_patterns(self, code_content: str) -> Dict[str, List[str]]:
        """Check for fraud patterns in code"""
        detected_patterns = {}
        
        for category, patterns in self.fraud_patterns.items():
            matches = []
            for pattern in patterns:
                found = re.findall(pattern, code_content, re.IGNORECASE)
                if found:
                    matches.extend(found)
            
            if matches:
                detected_patterns[category] = matches[:5]  # Limit display count
                
        return detected_patterns

    def check_urls(self, urls: List[str]) -> Dict[str, bool]:
        """Check if URL domains are malicious"""
        results = {}
        for url in urls:
            try:
                # Simple domain extraction
                if '://' in url:
                    domain = url.split('://')[1].split('/')[0].lower()
                else:
                    domain = url.split('/')[0].lower()
                
                results[url] = domain in self.malicious_domains
            except:
                results[url] = False
        
        return results

    def check_javascript(self, js_content: str) -> Dict[str, List[str]]:
        """Check for suspicious patterns in JavaScript"""
        # JavaScript fraud pattern rules - add specific detection rules here
        js_patterns = {
            # 'pattern_category': [r'regex_pattern1', r'regex_pattern2'],
            # 'wallet_interaction': [...],
            # 'suspicious_functions': [...]
        }
        
        detected = {}
        for category, patterns in js_patterns.items():
            matches = []
            for pattern in patterns:
                found = re.findall(pattern, js_content, re.IGNORECASE)
                if found:
                    matches.extend(found)
            
            if matches:
                detected[category] = matches[:3]
        
        return detected


def analyze_transaction_output(tx_hash: str):
    """Analyze transaction output data"""
    
    # Set paths
    output_dir = f"output/1/{tx_hash.lower()}"
    
    if not os.path.exists(output_dir):
        print(f"Output directory not found: {output_dir}")
        return
    
    print(f"Analyzing transaction: {tx_hash}")
    
    # Check for optional files in the output directory
    urls_file = os.path.join(output_dir, "url.txt")
    js_file = os.path.join(output_dir, "js.txt")
    
    # Give hints about optional files
    if not os.path.exists(urls_file):
        print(f"Optional: Create {urls_file} for URL analysis")
    else:
        print(f"Found URL file: {urls_file}")
        
    if not os.path.exists(js_file):
        print(f"Optional: Create {js_file} for JavaScript analysis")
    else:
        print(f"Found JS file: {js_file}")
    
    # Initialize checker
    checker = MaliciousChecker()
    
    # Extract addresses from decoded_trace.json
    trace_file = os.path.join(output_dir, "decoded_trace.json")
    addresses = []
    
    if os.path.exists(trace_file):
        try:
            with open(trace_file, 'r', encoding='utf-8') as f:
                trace_data = json.load(f)
            
            def extract_addresses(trace_item, addr_set):
                action = trace_item.get("action", {})
                if "from" in action:
                    addr_set.add(action["from"].lower())
                if "to" in action:
                    addr_set.add(action["to"].lower())
                for sub in trace_item.get("subtraces", []):
                    extract_addresses(sub, addr_set)
            
            addr_set = set()
            extract_addresses(trace_data, addr_set)
            addresses = list(addr_set)
            print(f"Found {len(addresses)} addresses")
            
        except Exception as e:
            print(f"Error reading trace file: {e}")
    
    # Check addresses
    addr_results = checker.check_addresses(addresses)
    malicious_addrs = [addr for addr, is_mal in addr_results.items() if is_mal]
    
    # Check code patterns
    code_file = os.path.join(output_dir, "code.txt")
    code_results = {}
    
    if os.path.exists(code_file):
        try:
            with open(code_file, 'r', encoding='utf-8') as f:
                code_content = f.read()
            code_results = checker.check_code_patterns(code_content)
        except Exception as e:
            print(f"Error reading code file: {e}")
    
    # Check URLs (optional)
    url_results = {}
    if os.path.exists(urls_file):
        try:
            with open(urls_file, 'r', encoding='utf-8') as f:
                urls = [line.strip() for line in f if line.strip()]
            url_results = checker.check_urls(urls)
            malicious_urls = [url for url, is_mal in url_results.items() if is_mal]
            print(f"Checked {len(urls)} URLs, found {len(malicious_urls)} malicious")
        except Exception as e:
            print(f"Error reading URLs file: {e}")
    
    # Check JavaScript (optional)
    js_results = {}
    if os.path.exists(js_file):
        try:
            with open(js_file, 'r', encoding='utf-8') as f:
                js_content = f.read()
            js_results = checker.check_javascript(js_content)
        except Exception as e:
            print(f"Error reading JavaScript file: {e}")
    
    # Generate report
    report = {
        'transaction_hash': tx_hash,
        'timestamp': datetime.now().isoformat(),
        'disclaimer': 'IMPORTANT: No detection of malicious addresses/patterns/links does not guarantee absolute safety. This tool only performs detection based on known databases and limited rules, and cannot guarantee 100% coverage of all risks. Please combine with other security tools and manual analysis for comprehensive judgment.',
        'summary': {
            'total_addresses': len(addresses),
            'malicious_addresses': len(malicious_addrs),
            'code_issues': len(code_results),
            'suspicious_urls': len([url for url, is_mal in url_results.items() if is_mal]),
            'js_issues': len(js_results)
        },
        'malicious_addresses': malicious_addrs,
        'code_patterns': code_results,
        'url_check': url_results,
        'js_patterns': js_results
    }
    
    # Print results
    print_security_report(report)
    
    # Save report
    report_file = os.path.join(output_dir, "security_report.json")
    with open(report_file, 'w', encoding='utf-8') as f:
        json.dump(report, f, indent=2, ensure_ascii=False)
    print(f"Security report saved to: {report_file}")


def print_security_report(report: Dict):
    """Print security analysis report"""
    print(f"\n" + "="*50)
    print(f"SECURITY ANALYSIS REPORT")
    print(f"="*50)
    print(f"Transaction: {report['transaction_hash']}")
    print(f"Time: {report['timestamp']}")
    
    # Display disclaimer
    print(f"\nDISCLAIMER:")
    print(f"No detection does not guarantee safety.")
    print(f"Tool limitation: known database + limited rules only.")
    print(f"Combine with other tools and manual analysis.")
    
    summary = report['summary']
    print(f"\nSUMMARY:")
    print(f"  Addresses: {summary['total_addresses']}")
    print(f"  Malicious: {summary['malicious_addresses']}")
    print(f"  Code Issues: {summary['code_issues']}")
    print(f"  Suspicious URLs: {summary['suspicious_urls']}")
    print(f"  JS Issues: {summary['js_issues']}")
    
    # Malicious addresses
    if report['malicious_addresses']:
        print(f"\nMALICIOUS ADDRESSES:")
        for addr in report['malicious_addresses']:
            print(f"  {addr}")
    else:
        print(f"\nNo malicious addresses detected")
    
    # Code patterns
    if report['code_patterns']:
        print(f"\nSUSPICIOUS CODE PATTERNS:")
        for category, matches in report['code_patterns'].items():
            print(f"  {category.upper()}: {len(matches)} matches")
            for match in matches:
                print(f"    {match}")
    else:
        print(f"\nNo suspicious code patterns detected")
    
    # URL check results
    if report['url_check']:
        malicious_urls = [url for url, is_mal in report['url_check'].items() if is_mal]
        if malicious_urls:
            print(f"\nMALICIOUS URLs:")
            for url in malicious_urls:
                print(f"  {url}")
        else:
            print(f"\nNo malicious URLs detected")
    
    # JavaScript check results
    if report['js_patterns']:
        print(f"\nSUSPICIOUS JAVASCRIPT PATTERNS:")
        for category, matches in report['js_patterns'].items():
            print(f"  {category.upper()}: {len(matches)} matches")
            for match in matches:
                print(f"    {match}")
    
    print(f"="*50)


if __name__ == "__main__":
    import sys
    
    # Usage example
    if len(sys.argv) != 2:
        print("Usage:")
        print("  python test_query.py <tx_hash>")
        print("\nExample:")
        print("  python test_query.py 0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32")
        print("\nOptional files (place in output/1/[tx_hash]/ directory):")
        print("  url.txt  - One URL per line for domain checking")
        print("  js.txt   - JavaScript code for pattern analysis")
        sys.exit(1)
    
    tx_hash = sys.argv[1]
    
    analyze_transaction_output(tx_hash) 